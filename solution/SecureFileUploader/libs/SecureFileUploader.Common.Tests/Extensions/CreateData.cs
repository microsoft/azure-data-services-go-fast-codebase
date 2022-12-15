using SecureFileUploader.Common.Dtos;

namespace SecureFileUploader.Common.Tests.Extensions;

public class CreateData
{
    public static List<InviteCsvRow> CreateValidCsvRows()
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

    public static List<InviteCsvRow> CreateValidAndEmptyCsvRows()
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
                Phn = "",
                CrmId = "",
                FolderName = "",
                PracticeId = "",
                GeneralPracticeName = "",
                GenericEmailAddress = "",
                ReportingQuarter = ""
            }
        };
        return rows;
    }

    public static List<InviteCsvRow> CreateInvalidCsvRows() => new();
}
