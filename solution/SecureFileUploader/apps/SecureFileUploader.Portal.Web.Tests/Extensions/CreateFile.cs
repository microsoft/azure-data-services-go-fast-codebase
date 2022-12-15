using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Portal.Web.Dtos;

namespace SecureFileUploader.Portal.Web.Tests.Extensions;

public class CreateFile
{
    private static List<InviteCsvRow> CreateValidCsvRows()
    {
        var rows = new List<InviteCsvRow> {
            new() {
                Phn = "123",
                CrmId = "123",
                FolderName = "Some_Folder",
                PracticeId = "123",
                GeneralPracticeName = "A_General_Practice",
                GenericEmailAddress = "A_Generic_Email_Address",
                ReportingQuarter = "q1"
            },
            new() {
                Phn = "1234",
                CrmId = "1234",
                FolderName = "Some_Folder",
                PracticeId = "1234",
                GeneralPracticeName = "A_General_Practice",
                GenericEmailAddress = "A_Generic_Email_Address",
                ReportingQuarter = "q2"
            }
        };
        return rows;
    }

    public static FileUpload CreateFileUploadModel()
    {
        var csvRows = CreateValidCsvRows();

        var fileCreate = MockIFormFile.GetFileMock("text/csv",
            "CrmId,Phn,PracticeId,GeneralPracticeName,FolderName,GenericEmailAddress\n" +
            string.Join("\n", csvRows.Select(x => $"{x.CrmId},{x.Phn},{x.PracticeId},{x.GeneralPracticeName},{x.FolderName},{x.GenericEmailAddress}")));

        // We should consider bringing this into the object fixture domain, where we have better control over the date time
        var utcNow = DateTime.UtcNow;
        var createdData = new FileUpload {
            CommencementDate = utcNow,
            SubmissionDeadline = utcNow.AddDays(2),
            TimeZone = "Australia/Perth",
            Name = "Test",
            File = fileCreate
        };
        return createdData;
    }
}
