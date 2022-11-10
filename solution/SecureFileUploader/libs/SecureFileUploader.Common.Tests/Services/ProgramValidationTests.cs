using FluentAssertions;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Models;
using SecureFileUploader.Common.Services;

namespace SecureFileUploader.Common.Tests.Services;

public class ProgramValidationTests
{
    private readonly IClock _clock;

    public ProgramValidationTests()
    {
        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
    }

    [Fact]
    public void ValidateProgram_WhenProgramIsValid_ReturnsNoErrorCount()
    {
        // Arrange
        var program = new ProgramRequest {
            Name = "Test Program",
            CommencementDate = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(2),
            SubmissionDeadline = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(10),
            TimeZone = "UTC"
        };

        var validate = ValidationService.ValidateProgram(program);
        validate.Should().BeOfType<ValidationErrorModel>();
        validate.ErrorMessage.Count.Should().Be(0);
    }

    [Fact]
    public void ValidateProgram_WhenProgramCommencementDateIsInPast_ReturnOneErrorCount()
    {
        // Arrange
        var program = new ProgramRequest {
            Name = "Test Program",
            CommencementDate = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(-1),
            SubmissionDeadline = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(2),
            TimeZone = "UTC"
        };

        var validate = ValidationService.ValidateProgram(program);

        validate.Should().BeOfType<ValidationErrorModel>();
        validate.ErrorMessage.Count.Should().Be(1);
    }

    [Fact]
    public void ValidateProgram_WhenProgramSubmissionDeadlineDateIsInPast_ReturnTwoErrorCount()
    {
        // Arrange
        var program = new ProgramRequest {
            Name = "Test Program",
            CommencementDate = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(2),
            SubmissionDeadline = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(-2),
            TimeZone = "UTC"
        };

        var validate = ValidationService.ValidateProgram(program);

        validate.Should().BeOfType<ValidationErrorModel>();
        validate.ErrorMessage.Count.Should().Be(2);
    }

    [Fact]
    public void ValidateProgram_WhenProgramSubmissionDeadlineIsBeforeCommencementDate_ReturnOneErrorCount()
    {
        // Arrange
        var program = new ProgramRequest {
            Name = "Test Program",
            CommencementDate = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(3),
            SubmissionDeadline = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(1),
            TimeZone = "UTC"
        };

        var validate = ValidationService.ValidateProgram(program);

        validate.Should().BeOfType<ValidationErrorModel>();
        validate.ErrorMessage.Count.Should().Be(1);
    }

    [Fact]
    public void ValidateProgram_WhenProgramsDatesAreNotInUTC_ReturnTwoErrorCount()
    {
        // Arrange
        var program = new ProgramRequest() {
            Name = "Test Program",
            CommencementDate = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(3).ToLocalTime(),
            SubmissionDeadline = _clock.GetCurrentInstant().ToDateTimeUtc().AddDays(5).ToLocalTime(),
            TimeZone = "UTC"
        };

        var validate = ValidationService.ValidateProgram(program);

        validate.Should().BeOfType<ValidationErrorModel>();
        validate.ErrorMessage.Count.Should().Be(2);
    }

    [Fact]
    public void ValidateInvitee_WhenInviteeListIsValid_ReturnNoError()
    {
        var invitees = new List<InviteeRequest> {
                new() {
                    CrmId = "23",
                    Phn = "CountryWA",
                    PracticeId = "2131",
                    GeneralPracticeName = "Testing_Via_Request",
                    FolderName = "FunctionsFolder",
                    GenericEmailAddress = "person@example.com",
                    ReportingQuarter = "Q4"
                }
        };

        var validation = ValidationService.ValidateInvitee(invitees);

        validation.Should().BeOfType<ValidationErrorModel>();
        validation.ErrorMessage.Count.Should().Be(0);
    }

    [Fact]
    public void ValidateInvitee_WhenInviteeListEmpty_ReturnOneError()
    {
        var validation = ValidationService.ValidateInvitee(new List<InviteeRequest>());

        validation.Should().BeOfType<ValidationErrorModel>();
        validation.ErrorMessage.Count.Should().Be(1);
    }
}
