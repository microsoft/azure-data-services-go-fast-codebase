using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using Moq.Contrib.ExpressionBuilders.Logging;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Resources;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Tests.Extensions;
using SecureFileUploader.Common.Tests.Infrastructure;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Data.Models;
using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;
using InviteeAccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;
using InviteeAccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;

namespace SecureFileUploader.Common.Tests.Services;

public class AccessTokenServiceTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;
    private const string _name = "TestName";
    private readonly Mock<ISettingsService> _settingsServiceMock;

    public AccessTokenServiceTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _settingsServiceMock = new Mock<ISettingsService>();
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    private CreateAccessTokenServiceOptions WithDefaultCreateOptions => new() {
        Logger = Mock.Of<ILogger<AccessTokenService>>(),
        Mapper = _mapper,
        DbContext = CreateDbContext()
    };

    [Fact]
    public async Task WhenGeneratingNewAccessTokenForInviteeThatDoesNotExist_ThrowsKeyNotFoundException()
    {
        var accessTokenService = CreateAccessTokenService();

        var invocation = accessTokenService.Awaiting(x => x.GenerateForInviteeAsync(_objectFactory.Create<Guid>()));

        await invocation.Should().ThrowAsync<KeyNotFoundException>().WithMessage(ExceptionMessages.InviteeNotFound);
    }

    [Fact]
    public async Task WhenGeneratingNewAccessTokenForInviteeThatHasExistingAccessToken_ThrowsInvalidOperationException()
    {
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>().With(x => x.IsActive, true).Create();
        var invitee = _objectFactory.Build<InviteeDataModel>().With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection()).Create();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);

        var accessTokenService = CreateAccessTokenService(x => x.DbContext = dbContext);

        var invocation = accessTokenService.Awaiting(x => x.GenerateForInviteeAsync(invitee.Id));

        await invocation.Should().ThrowAsync<InvalidOperationException>().WithMessage(ExceptionMessages.ActiveAccessTokenFound);
    }

    [Fact]
    public async Task WhenGeneratingNewAccessTokenForInviteeThatHasNoExistingAccessToken_PersistsAndReturnsNewAccessToken()
    {
        var invitee = _objectFactory.Build<InviteeDataModel>().Without(x => x.AccessTokens).Without(x => x.InviteeEvents).Create();
        var settings = _objectFactory.Build<SettingsDataModel>().With(x => x.FileUnit, "MB").Create();
        var utcNow = _objectFactory.UtcNow();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);
        await dbContext.AddAsync(settings);
        await dbContext.SaveChangesAsync();

        var settingsDto = _mapper.Map<SettingsDto>(settings);

        _settingsServiceMock.Setup(x => x.GetAllCurrentSystemSettingsAsync())
            .ReturnsAsync(settingsDto);

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.DbContext = dbContext;
            x.SettingsService = _settingsServiceMock.Object;
        });

        var generatedAccessToken = await accessTokenService.GenerateForInviteeAsync(invitee.Id);

        using (new AssertionScope())
        {
            var persistedAccessToken = dbContext.AccessToken.Single();
            persistedAccessToken.InviteeId.Should().Be(invitee.Id);
            persistedAccessToken.Token.Should().NotBeEmpty();
            Guid.TryParse(persistedAccessToken.Token, out _).Should().BeTrue();
            persistedAccessToken.StartsOn.Should().Be(utcNow);
            persistedAccessToken.EndsOn.Should().Be(utcNow.AddDays(settings.InviteTimeToLiveDays));
            persistedAccessToken.IsActive.Should().BeTrue();
            persistedAccessToken.GeneratedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedBy.Should().Be(_name);
            persistedAccessToken.LastModifiedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedBy.Should().Be(_name);

            generatedAccessToken.Should().BeEquivalentTo(_mapper.Map<InviteeAccessTokenDto>(persistedAccessToken));
        }
    }

    [Fact]
    public async Task WhenProgramCommencedAndInviteeDoesNotHaveAccessToken_NewAccessTokenGeneratedAndPersisted()
    {
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .Without(x => x.AccessTokens)
            .Without(x => x.InviteeEvents).Create();
        var settings = _objectFactory.Create<SettingsDataModel>();
        var utcNow = _objectFactory.UtcNow();

        var logger = Mock.Of<ILogger<AccessTokenService>>();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);
        await dbContext.AddAsync(settings);
        await dbContext.SaveChangesAsync();

        var settingsDto = _mapper.Map<SettingsDto>(settings);

        _settingsServiceMock.Setup(x => x.GetAllCurrentSystemSettingsAsync())
            .ReturnsAsync(settingsDto);

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.Logger = logger;
            x.DbContext = dbContext;
            x.SettingsService = _settingsServiceMock.Object;
        });

        await accessTokenService.GenerateForCommencedProgramsAsync();

        using (new AssertionScope())
        {
            var persistedAccessToken = await dbContext.AccessToken.SingleAsync();
            persistedAccessToken.InviteeId.Should().Be(invitee.Id);
            persistedAccessToken.Token.Should().NotBeEmpty();
            Guid.TryParse(persistedAccessToken.Token, out _).Should().BeTrue();
            persistedAccessToken.StartsOn.Should().Be(utcNow);
            persistedAccessToken.EndsOn.Should().Be(utcNow.AddDays(settings.InviteTimeToLiveDays));
            persistedAccessToken.IsActive.Should().BeTrue();
            persistedAccessToken.GeneratedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedBy.Should().Be(_name);
            persistedAccessToken.LastModifiedOn.Should().Be(utcNow);
            persistedAccessToken.CreatedBy.Should().Be(_name);

            logger.Verify(
                Log.With.LogLevel(LogLevel.Information)
                    .And.LogMessage(LogMessages.FoundInitialInviteeAccessTokenToGenerate)
                    .And.LoggedValue("inviteeCount", 1),
                Times.Once);
        }
    }

    [Fact]
    public async Task WhenProgramCommencedAndInviteeDoesHaveAccessToken_NoChangesMade()
    {
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, true)
            .Without(x => x.Invitee)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .Without(x => x.InviteeEvents).Create();

        var logger = Mock.Of<ILogger<AccessTokenService>>();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);
        await dbContext.SaveChangesAsync();

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.Logger = logger;
            x.DbContext = dbContext;
        });

        await accessTokenService.GenerateForCommencedProgramsAsync();

        using (new AssertionScope())
        {
            dbContext.Invitee.Single().Should().BeEquivalentTo(invitee);
            dbContext.AccessToken.Single().Should().BeEquivalentTo(accessToken);

            logger.Verify(
                Log.With.LogLevel(LogLevel.Information)
                    .And.LogMessage(LogMessages.NoInitialInviteeAccessTokensToGenerate),
                Times.Once);
        }
    }

    [Fact]
    public async Task WhenValidatingToken_ProgramClosedAndInviteeDoesHaveAccessToken_NoAccess()
    {
        var program = _objectFactory.Build<Program>()
            .With(x => x.CommencementDate, DateTime.UtcNow.AddDays(-5))
            .With(x => x.SubmissionDeadline, DateTime.UtcNow.AddDays(-1))
            .Without(x => x.Invitees)
            .Create();
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, true)
            .With(x => x.StartsOn, DateTime.UtcNow.AddDays(-1))
            .With(x => x.EndsOn, DateTime.UtcNow.AddDays(1))
            .With(x => x.Token, new Guid().ToString)
            .Without(x => x.Invitee)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .With(x => x.Program, program)
            .Without(x => x.InviteeEvents).Create();

        var logger = Mock.Of<ILogger<AccessTokenService>>();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);
        await dbContext.SaveChangesAsync();

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.Logger = logger;
            x.DbContext = dbContext;
        });

        var validAccessToken = await accessTokenService.ValidateToken(Guid.Parse(accessToken.Token));

        using (new AssertionScope())
        {
            validAccessToken.Should().BeNull();
        }
    }

    [Fact]
    public async Task WhenValidatingToken_ProgramOpenAndInviteeDoesHaveAccessToken_HasAccess()
    {
        var program = _objectFactory.Build<Program>()
            .With(x => x.CommencementDate, DateTime.UtcNow.AddDays(-5))
            .With(x => x.SubmissionDeadline, DateTime.UtcNow.AddDays(5))
            .Without(x => x.Invitees)
            .Create();
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsActive, true)
            .With(x => x.StartsOn, DateTime.UtcNow.AddDays(-1))
            .With(x => x.EndsOn, DateTime.UtcNow.AddDays(1))
            .With(x => x.Token, new Guid().ToString)
            .Without(x => x.Invitee)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .With(x => x.Program, program)
            .Without(x => x.InviteeEvents).Create();

        var logger = Mock.Of<ILogger<AccessTokenService>>();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(invitee);
        await dbContext.SaveChangesAsync();

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.Logger = logger;
            x.DbContext = dbContext;
        });

        var validAccessToken = await accessTokenService.ValidateToken(Guid.Parse(accessToken.Token));

        using (new AssertionScope())
        {
            validAccessToken.Should().NotBeNull();
        }
    }

    [Fact]
    public async Task WhenRetrievingAllPendingAccessTokensAndSourceHasPendingAccessTokens_ReturnsAllPendingAccessTokens()
    {
        var accessToken = _objectFactory.CreatePendingInviteeAccessTokenDataModel();

        var dbContext = CreateDbContext();
        await dbContext.AddAsync(accessToken);
        await dbContext.SaveChangesAsync();

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.DbContext = dbContext;
        });

        var pendingAccessTokens = await accessTokenService.GetAllPendingAsync();

        pendingAccessTokens.Should().BeEquivalentTo(accessToken.ToListOfSelf());
    }

    [Fact]
    public async Task WhenRetrievingAllPendingAccessTokensAndSourceDoesNotHavePendingAccessTokens_ReturnsEmptyList()
    {
        var accessTokens = new List<InviteeAccessTokenDataModel> {
            _objectFactory.CreateActiveInviteeAccessTokenDataModel(),
            _objectFactory.CreateExpiredInviteeAccessTokenDataModel()
        };

        var dbContext = CreateDbContext();
        await dbContext.AddRangeAsync(accessTokens);
        await dbContext.SaveChangesAsync();

        var accessTokenService = CreateAccessTokenService(x =>
        {
            x.DbContext = dbContext;
        });

        var pendingAccessTokens = await accessTokenService.GetAllPendingAsync();

        pendingAccessTokens.Should().BeEmpty();
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        new FakeClock(Instant.FromDateTimeUtc(_objectFactory.UtcNow())),
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == _name));

    private AccessTokenService CreateAccessTokenService(Action<CreateAccessTokenServiceOptions>? createOptions = null)
    {
        var resolvedCreateOptions = WithDefaultCreateOptions;
        createOptions?.Invoke(resolvedCreateOptions);
        return CreateAccessTokenService(resolvedCreateOptions);
    }

    private AccessTokenService CreateAccessTokenService(CreateAccessTokenServiceOptions createOptions) =>
        new(createOptions.Logger,
            createOptions.Mapper,
            new FakeClock(Instant.FromDateTimeUtc(_objectFactory.UtcNow())),
            createOptions.DbContext,
            Mock.Of<IInviteeEventTypeService>(),
            createOptions.SettingsService);

    private class CreateAccessTokenServiceOptions
    {
        public ILogger<AccessTokenService> Logger { get; set; }

        public IMapper Mapper { get; set; }

        public SecureFileUploaderContext DbContext { get; set; }

        public ISettingsService SettingsService { get; set; }
    }
}
