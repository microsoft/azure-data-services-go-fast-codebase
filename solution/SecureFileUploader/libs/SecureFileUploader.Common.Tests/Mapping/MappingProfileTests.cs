using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Tests.Infrastructure;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;
using InviteeEventDto = SecureFileUploader.Common.Dtos.Event;
using InviteeAccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;
using InviteeAccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Common.Tests.Mapping;

public class MappingProfileTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;

    public MappingProfileTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Theory]
    [InlineData(false, InviteeStatus.Pending)]
    [InlineData(true, InviteeStatus.Completed)]
    public void WhenMappingInviteeDataModelToInviteeDto_ReturnsValidInviteeDto(bool isFileUploaded, InviteeStatus expectedStatus)
    {
        var invitee = _objectFactory.Build<InviteeDataModel>().With(x => x.IsFileUploaded, isFileUploaded).Create();

        var mappedInvitee = _mapper.Map<InviteeDto>(invitee);
        var mappedAccessTokens = _mapper.Map<List<InviteeAccessTokenDto>>(invitee.AccessTokens);
        var mappedEvents = _mapper.Map<List<InviteeEventDto>>(invitee.InviteeEvents);
        var mappedSendGridEmails = _mapper.Map<List<SendGridEmailDto>>(invitee.SendGridEmails);

        using (new AssertionScope())
        {
            mappedInvitee.Id.Should().Be(invitee.Id);
            mappedInvitee.CrmId.Should().Be(invitee.CrmId);
            mappedInvitee.PHN.Should().Be(invitee.PHN);
            mappedInvitee.PracticeId.Should().Be(invitee.PracticeId);
            mappedInvitee.PracticeName.Should().Be(invitee.Name);
            mappedInvitee.FolderName.Should().Be(invitee.ContainerName);
            mappedInvitee.EmailAddress.Should().Be(invitee.Email);
            mappedInvitee.Status.Should().Be(expectedStatus);
            mappedInvitee.AccessTokens.Should().BeEquivalentTo(mappedAccessTokens);
            mappedInvitee.Events.Should().BeEquivalentTo(mappedEvents);
            mappedInvitee.SendGridEmails.Should().BeEquivalentTo(mappedSendGridEmails);
        }
    }

    [Fact]
    public void WhenMappingInviteeEventDataModelToInviteeEventDto_ReturnsValidInviteeEventDto()
    {
        var inviteeEvent = _objectFactory.Create<InviteeEventDataModel>();

        var mappedInviteeEvent = _mapper.Map<InviteeEventDto>(inviteeEvent);

        using (new AssertionScope())
        {
            mappedInviteeEvent.TriggeredAt.Should().Be(inviteeEvent.PerformedOn);
            mappedInviteeEvent.Description.Should().Be(inviteeEvent.Description);
            mappedInviteeEvent.TriggeredBy.Should().Be(inviteeEvent.PerformedBy);
        }
    }

    [Fact]
    public void WhenMappingInviteeAccessTokenDataModelToInviteeAccessTokenDto_ReturnsValidInviteeAccessTokenDto()
    {
        var inviteeAccessToken = _objectFactory.Create<InviteeAccessTokenDataModel>();

        var mappedInviteeAccessToken = _mapper.Map<InviteeAccessTokenDto>(inviteeAccessToken);

        using (new AssertionScope())
        {
            mappedInviteeAccessToken.Id.Should().Be(inviteeAccessToken.Id);
            mappedInviteeAccessToken.IsActive.Should().Be(inviteeAccessToken.IsActive);
            mappedInviteeAccessToken.GeneratedAt.Should().Be(inviteeAccessToken.GeneratedOn);
            mappedInviteeAccessToken.ActiveWindowStartsAt.Should().Be(inviteeAccessToken.StartsOn);
            mappedInviteeAccessToken.ActiveWindowEndsAt.Should().Be(inviteeAccessToken.EndsOn);
            mappedInviteeAccessToken.GeneratedBy.Should().Be(inviteeAccessToken.CreatedBy);
        }
    }
}
