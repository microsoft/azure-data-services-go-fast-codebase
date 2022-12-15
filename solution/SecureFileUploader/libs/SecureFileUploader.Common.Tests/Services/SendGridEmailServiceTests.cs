using System.Dynamic;
using System.Net;
using AutoFixture;
using AutoMapper;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using Newtonsoft.Json;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Tests.Infrastructure;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Data.Models;
using SendGrid;
using Invitee = SecureFileUploader.Data.Models.Invitee;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Common.Tests.Services;

public class SendGridEmailServiceTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;
    private readonly IClock _clock;

    public SendGridEmailServiceTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WithValidModel_SaveNewSendGridRow()
    {
        // empty context
        var dbContext = CreateDbContext();
        var guidToCheck = Guid.NewGuid();
        var guids = new List<Guid> {
            guidToCheck
        };

        var invitee = _objectFactory.Build<Invitee>()
            .With(x => x.Email, "one@email.com")
            .With(x => x.Id, guidToCheck)
            .Without(x => x.SendGridEmails).Create();
        dbContext.Invitee.Add(invitee);
        await dbContext.SaveChangesAsync();

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, Mock.Of<ISendGridClient>(),
            Mock.Of<IInviteeEventTypeService>(), _clock);
        await saveSendGrid.SaveNewSendGridEmailAsync("someId", guids, _clock.GetCurrentInstant().ToDateTimeUtc());

        // check context isn't empty
        dbContext.SendGridEmail.Should().ContainSingle();
    }

    [Fact]
    public async Task WithCommaSeparatedEmailInviteeField_SaveMultipleSendGridRow()
    {
        // empty context
        var dbContext = CreateDbContext();
        var guidToCheck = Guid.NewGuid();
        var guids = new List<Guid> {
            guidToCheck
        };

        var invitee = _objectFactory.Build<Invitee>()
            .With(x => x.Email, "one@email.com,two@email.com")
            .With(x => x.Id, guidToCheck)
            .Without(x => x.SendGridEmails).Create();

        dbContext.Invitee.Add(invitee);
        await dbContext.SaveChangesAsync();

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, Mock.Of<ISendGridClient>(),
            Mock.Of<IInviteeEventTypeService>(), _clock);
        await saveSendGrid.SaveNewSendGridEmailAsync("someId", guids, _clock.GetCurrentInstant().ToDateTimeUtc());

        // should have 2 now
        dbContext.SendGridEmail.Count().Should().BeOneOf(2);
    }

    [Fact]
    public async Task WithNewBounces_AndNoSendGridEmails_SaveNothing()
    {
        var dbContext = CreateDbContext();
        var bounces = _objectFactory.Create<List<SendGridBounceResponse>>();

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, Mock.Of<ISendGridClient>(),
            Mock.Of<IInviteeEventTypeService>(), _clock);
        // nothing to be updated, must be some weird other bounces from another API key interfering
        await saveSendGrid.SaveSendGridBounceEmailsAsync(bounces);

        dbContext.SendGridEmail.Should().BeEmpty();
    }

    [Fact]
    public async Task WithNewBounces_NoMatchEmail_UpdateNothing()
    {
        var dbContext = CreateDbContext();
        var bounces = _objectFactory.Create<List<SendGridBounceResponse>>();
        var newGuid = Guid.NewGuid();
        var guids = new List<Guid> {
            newGuid
        };

        var invitee = _objectFactory.Build<Invitee>()
            .With(x => x.Email, "one@email.com")
            .With(x => x.Id, newGuid)
            .Without(x => x.SendGridEmails).Create();

        dbContext.Invitee.Add(invitee);
        await dbContext.SaveChangesAsync();

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, Mock.Of<ISendGridClient>(),
            Mock.Of<IInviteeEventTypeService>(), _clock);
        await saveSendGrid.SaveNewSendGridEmailAsync("someId", guids, _clock.GetCurrentInstant().ToDateTimeUtc());
        // surely unrelated
        await saveSendGrid.SaveSendGridBounceEmailsAsync(bounces);

        dbContext.SendGridEmail.Should().ContainSingle();
        // now check the relevant row has not been updated
        var email = await dbContext.SendGridEmail.FirstOrDefaultAsync();
        email!.BouncedOn.Should().BeNull();
        email.BouncedReason.Should().BeNull();
    }

    [Fact]
    public async Task WithNewBounces_AndMatchingInvitees_UpdateBouncedInformation()
    {
        var dbContext = CreateDbContext();

        var inviteeEventService = new Mock<IInviteeEventTypeService>();
        inviteeEventService.Setup(x => x.GetOrAddAsync(It.IsAny<string>()))
            .ReturnsAsync(_objectFactory.Create<InviteeEventType>());

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, Mock.Of<ISendGridClient>(),
            inviteeEventService.Object, _clock);

        var multiEmail = "some@email.com,someother@email.com";
        var invitee = _objectFactory.Build<Invitee>().With(x => x.Email, multiEmail).Create();
        var newEmails = _objectFactory.Build<SendGridEmailModel>()
            .With(x => x.Email, multiEmail)
            .With(x => x.Invitee, invitee)
            .Create();
        await dbContext.SendGridEmail.AddRangeAsync(newEmails);
        await dbContext.SaveChangesAsync();

        var sendGridEmails = await dbContext.SendGridEmail.ToListAsync();

        var bounces = sendGridEmails.Select(sendGridEmail =>
                _objectFactory.Build<SendGridBounceResponse>().With(x => x.Email, sendGridEmail.Email).Create())
            .ToList();

        var emails = await saveSendGrid.SaveSendGridBounceEmailsAsync(bounces);

        emails.Should().NotBeEmpty();

        // check all have BouncedOn, BounceReason
        await foreach (var sendGridEmail in dbContext.SendGridEmail)
        {
            sendGridEmail.BouncedOn.Should().NotBeNull();
            sendGridEmail.BouncedReason.Should().NotBeNull();
        }
    }

    [Fact]
    public async Task WithValidDatetime_FindBounces()
    {
        var dbContext = CreateDbContext();

        var bounceResponse = new List<SendGridBounceResponse> {
            new() {
                Created = 1234,
                Email = "some@email.com",
                Reason = "some_reason",
                Status = "bounced"
            }
        };

        var sendGridClientMock = new Mock<ISendGridClient>();

        var content = new StringContent(JsonConvert.SerializeObject(bounceResponse));
        var fakeResponse = new System.Net.Http.HttpResponseMessage();
        var fakeResponseHeader = fakeResponse.Headers;
        fakeResponseHeader.Add("Some_response_header", "123xyz");

        var response = new Response(HttpStatusCode.OK, content, fakeResponseHeader);

        sendGridClientMock
            .Setup(x => x.RequestAsync(BaseClient.Method.GET, null, It.IsAny<string>(), It.IsAny<string>(),
                It.IsAny<CancellationToken>())).Returns(() => Task.FromResult(response));

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, sendGridClientMock.Object,
            Mock.Of<IInviteeEventTypeService>(), _clock);

        var results =
            await saveSendGrid.FetchSendGridBouncesAsync(DateTimeOffset.UtcNow, DateTimeOffset.UtcNow.AddMinutes(-5));

        results.Should().NotBeEmpty();
        results.Count.Should().BeOneOf(1);
    }

    [Fact]
    public async Task WhenNoBouncesFound_NoneReturned()
    {
        var dbContext = CreateDbContext();

        // empty
        var bounceResponse = new List<SendGridBounceResponse>();
        var sendGridClientMock = new Mock<ISendGridClient>();

        var content = new StringContent(JsonConvert.SerializeObject(bounceResponse));
        var fakeResponse = new System.Net.Http.HttpResponseMessage();
        var fakeResponseHeader = fakeResponse.Headers;
        fakeResponseHeader.Add("Some_response_header", "123xyz");

        var response = new Response(HttpStatusCode.OK, content, fakeResponseHeader);

        sendGridClientMock
            .Setup(x => x.RequestAsync(BaseClient.Method.GET, null, It.IsAny<string>(), It.IsAny<string>(),
                It.IsAny<CancellationToken>())).Returns(() => Task.FromResult(response));

        var saveSendGrid = new SendGridEmailService(dbContext,
            Mock.Of<ILogger<SendGridEmailService>>(), _mapper, sendGridClientMock.Object,
            Mock.Of<IInviteeEventTypeService>(), _clock);

        var results =
            await saveSendGrid.FetchSendGridBouncesAsync(DateTimeOffset.UtcNow, DateTimeOffset.UtcNow.AddMinutes(-5));

        results.Should().BeEmpty();
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        _clock,
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));
}
