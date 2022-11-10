using CsvHelper;
using CsvHelper.Configuration;
using FluentAssertions;
using Moq;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Tests.Extensions;
using SecureFileUploader.Portal.Web.Tests.Extensions;
using CsvParser = SecureFileUploader.Portal.Web.Services.CsvParser;

namespace SecureFileUploader.Portal.Web.Tests.Services;

public class CsvParserTest
{
    [Fact]
    public async Task WhenGettingCsvFileRecords_ReturnsExpectedRecords()
    {
        var expectedResult = CreateData.CreateValidCsvRows();
        var file = MockIFormFile.GetFileMock(
            "text/csv",
            "CrmId,Phn,PracticeId,GeneralPracticeName,FolderName,GenericEmailAddress\n" +
            string.Join("\n", expectedResult.Select(x => $"{x.CrmId},{x.Phn},{x.PracticeId},{x.GeneralPracticeName},{x.FolderName},{x.GenericEmailAddress}")));
        var csvReader = new Mock<IReader>();
        csvReader.Setup(x => x.GetRecordsAsync<InviteCsvRow>(It.IsAny<CancellationToken>())).Returns(() => expectedResult.ToAsyncEnumerable());
        var csvFactoryMock = new Mock<IFactory>();
        csvFactoryMock.Setup(x => x.CreateReader(It.IsAny<TextReader>(), It.IsAny<CsvConfiguration>())).Returns(() => csvReader.Object);

        var csvParser = new CsvParser(csvFactoryMock.Object);

        var actualResult = await csvParser.GetRecordsAsync<InviteCsvRow>(file);

        actualResult.Should().BeEquivalentTo(expectedResult);
    }
    // Note: having trouble constructing an "empty row test case" that wouldn't just return a full set of rows anyway
}
