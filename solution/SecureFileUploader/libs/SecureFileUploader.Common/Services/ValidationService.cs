using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Models;

namespace SecureFileUploader.Common.Services;

public static class ValidationService
{

    public static ValidationErrorModel ValidateProgram(BaseProgram program)
    {
        var model = new ValidationErrorModel();

        if (program.CommencementDate.Kind != DateTimeKind.Utc)
        {
            model.ErrorMessage.Add("CommencementDate must be in UTC format Example: 2021-01-01T00:00:00Z");
        }

        if (program.SubmissionDeadline.Kind != DateTimeKind.Utc)
        {
            model.ErrorMessage.Add("SubmissionDeadline must be in UTC format Example: 2021-01-01T00:00:00Z");
        }

        if (program.CommencementDate < DateTime.UtcNow)
        {
            model.ErrorMessage.Add("Commencement date must be in the future");
        }

        if (program.SubmissionDeadline < DateTime.UtcNow)
        {
            model.ErrorMessage.Add("Submission deadline must be in the future");
        }

        if (program.CommencementDate > program.SubmissionDeadline)
        {
            model.ErrorMessage.Add("Commencement Date must be before Submission Deadline");
        }

        return model;
    }

    public static ValidationErrorModel ValidateInvitee(IEnumerable<BaseInvitee> invitees)
    {
        var model = new ValidationErrorModel();

        if (!invitees.Any())
        {
            model.ErrorMessage.Add("Invitees list is empty");
        }

        return model;
    }
}
