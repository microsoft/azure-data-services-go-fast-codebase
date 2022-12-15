using System.Globalization;
using CsvHelper;
using CsvHelper.Configuration;
using SecureFileUploader.Portal.Web.Interfaces;

namespace SecureFileUploader.Portal.Web.Services;

public class CsvParser : ICsvParser
{
    private readonly IFactory _csvFactory;
    private readonly CsvConfiguration _configuration;

    public CsvParser(IFactory csvFactory)
    {
        _csvFactory = csvFactory;
        _configuration = new CsvConfiguration(CultureInfo.InvariantCulture) {
            // Noted a tendency for users to submit blank rows, ignore these
            ShouldSkipRecord = record =>
                record.Row.Parser.Record != null && record.Row.Parser.Record.All(string.IsNullOrWhiteSpace)
        };
    }

    public async Task<List<T>> GetRecordsAsync<T>(IFormFile file)
    {
        await using var ms = new MemoryStream();
        await file.CopyToAsync(ms);
        ms.Seek(0, SeekOrigin.Begin);

        using var streamReader = new StreamReader(ms);
        using var csvReader = _csvFactory.CreateReader(streamReader, _configuration);

        var records = new List<T>();
        await foreach (var record in csvReader.GetRecordsAsync<T>()) records.Add(record);
        return records;
    }
}
