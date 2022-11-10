using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Mapping;
using SecureFileUploader.Portal.Web.Tests.Extensions;
using SecureFileUploader.Portal.Web.Tests.Infrastructure;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramDto = SecureFileUploader.Portal.Web.Dtos.Program;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeAccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;

namespace SecureFileUploader.Portal.Web.Tests.Mapping;

public class MappingProfileTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;

    public MappingProfileTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    public static IEnumerable<object[]> WhenResolvingTheProgramStatusUsingVariousInput_ReturnsExpectedPendingStatus_Input =>
        new List<object[]> {
            new object[] { true, DateTime.UtcNow.AddDays(1), ProgramStatus.Open },
            new object[] { true, DateTime.UtcNow.AddDays(-1), ProgramStatus.Closed },
            new object[] { false, DateTime.UtcNow.AddDays(2), ProgramStatus.Pending }
        };

    [Theory]
    [MemberData(nameof(WhenResolvingTheProgramStatusUsingVariousInput_ReturnsExpectedPendingStatus_Input))]
    public void WhenResolvingTheProgramStatusUsingVariousInput_ReturnsExpectedPendingStatus(
        bool isCommenced, DateTime submissionDeadline, ProgramStatus expectedProgramStatus) =>
        MappingProfile.ResolveProgramStatus(isCommenced, submissionDeadline).Should().Be(expectedProgramStatus);

    [Fact]
    public void WhenMappingProgramDataModelToProgramSummaryDto_ReturnsValidProgramSummaryDto()
    {
        var invitees = new List<InviteeDataModel> {
            _objectFactory.Build<InviteeDataModel>().With(x => x.IsFileUploaded, false).Create(),
            _objectFactory.Build<InviteeDataModel>().With(x => x.IsFileUploaded, true).Create()
        };

        var program = _objectFactory.Build<ProgramDataModel>()
            .With(x => x.IsCommenced, true)
            .With(x => x.CommencementDate, DateTime.UtcNow.AddDays(-1))
            .With(x => x.SubmissionDeadline, DateTime.UtcNow.AddDays(1))
            .With(x => x.Invitees, invitees.ToObservableCollection())
            .Create();

        var mappedProgramSummary = _mapper.Map<ProgramSummary>(program);

        using (new AssertionScope())
        {
            mappedProgramSummary.Id.Should().Be(program.Id);
            mappedProgramSummary.Name.Should().Be(program.Name);
            mappedProgramSummary.CommencementDate.Should().Be(program.CommencementDate);
            mappedProgramSummary.SubmissionDeadline.Should().Be(program.SubmissionDeadline);
            mappedProgramSummary.NumberOfInvitees.Should().Be(2);
            mappedProgramSummary.NumberOfInviteesThatHaveUploaded.Should().Be(1);
            mappedProgramSummary.Status.Should().Be(ProgramStatus.Open);
        }
    }

    [Fact]
    public void WhenMappingProgramDataModelToProgramDto_ReturnsValidProgramDto()
    {
        var program = _objectFactory.Build<ProgramDataModel>()
            .With(x => x.IsCommenced, true)
            .With(x => x.CommencementDate, DateTime.UtcNow.AddDays(-1))
            .With(x => x.SubmissionDeadline, DateTime.UtcNow.AddDays(1))
            .Create();

        var mappedProgram = _mapper.Map<ProgramDto>(program);
        var mappedInviteeSummaries = _mapper.Map<List<InviteeSummary>>(program.Invitees);

        using (new AssertionScope())
        {
            mappedProgram.Id.Should().Be(program.Id);
            mappedProgram.Name.Should().Be(program.Name);
            mappedProgram.CommencementDate.Should().Be(program.CommencementDate);
            mappedProgram.SubmissionDeadline.Should().Be(program.SubmissionDeadline);
            mappedProgram.Invitees.Should().BeEquivalentTo(mappedInviteeSummaries);
            mappedProgram.Status.Should().Be(ProgramStatus.Open);
        }
    }

    [Theory]
    [InlineData(false, false, InviteeStatus.Pending)]
    [InlineData(true, false, InviteeStatus.Pending)]
    //The state !hasBeenInvited && hasUploaded is not valid and should not occur
    [InlineData(true, true, InviteeStatus.Completed)]
    public void WhenMappingInviteeDataModelToInviteeSummaryDto_ReturnsValidInviteeSummaryDto(bool expectedHasBeenInvited, bool expectedHasUploaded, InviteeStatus expectedStatus)
    {
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsSentToMailProvider, expectedHasBeenInvited)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.IsFileUploaded, expectedHasUploaded)
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .Without(x => x.SendGridEmails)
            .Create();

        var mappedInviteeSummary = _mapper.Map<InviteeSummary>(invitee);

        using (new AssertionScope())
        {
            mappedInviteeSummary.Id.Should().Be(invitee.Id);
            mappedInviteeSummary.PracticeName.Should().Be(invitee.Name);
            mappedInviteeSummary.EmailAddress.Should().Be(invitee.Email);
            mappedInviteeSummary.HasBeenInvited.Should().Be(expectedHasBeenInvited);
            mappedInviteeSummary.HasUploaded.Should().Be(expectedHasUploaded);
            mappedInviteeSummary.Status.Should().Be(expectedStatus);
        }
    }

    [Fact]
    public void WhenMappingInviteeDataModelWithSendGridBounces_withNoUpload_returnsValidInviteeSummaryDto()
    {
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsSentToMailProvider, true)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.IsFileUploaded, false)
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .Create();

        var mappedInviteeSummary = _mapper.Map<InviteeSummary>(invitee);

        using (new AssertionScope())
        {
            mappedInviteeSummary.Id.Should().Be(invitee.Id);
            mappedInviteeSummary.PracticeName.Should().Be(invitee.Name);
            mappedInviteeSummary.EmailAddress.Should().Be(invitee.Email);
            mappedInviteeSummary.HasBeenInvited.Should().Be(true);
            mappedInviteeSummary.HasUploaded.Should().Be(false);
            mappedInviteeSummary.Status.Should().Be(InviteeStatus.Bounced);
        }
    }

    [Fact]
    public void WhenMappingInviteeDataModelWithSendGridBounces_HasUploadedTakesPriority()
    {
        var accessToken = _objectFactory.Build<InviteeAccessTokenDataModel>()
            .With(x => x.IsSentToMailProvider, true)
            .Create();
        var invitee = _objectFactory.Build<InviteeDataModel>()
            .With(x => x.IsFileUploaded, true)
            .With(x => x.AccessTokens, accessToken.ToListOfSelf().ToObservableCollection())
            .Create();

        var mappedInviteeSummary = _mapper.Map<InviteeSummary>(invitee);

        using (new AssertionScope())
        {
            mappedInviteeSummary.Id.Should().Be(invitee.Id);
            mappedInviteeSummary.PracticeName.Should().Be(invitee.Name);
            mappedInviteeSummary.EmailAddress.Should().Be(invitee.Email);
            mappedInviteeSummary.HasBeenInvited.Should().Be(true);
            mappedInviteeSummary.HasUploaded.Should().Be(true);
            mappedInviteeSummary.Status.Should().Be(InviteeStatus.Completed);
        }
    }
}
