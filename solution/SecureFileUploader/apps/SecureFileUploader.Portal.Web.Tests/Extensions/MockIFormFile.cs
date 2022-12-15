using System.Text;
using Microsoft.AspNetCore.Http;

namespace SecureFileUploader.Portal.Web.Tests.Extensions;

public class MockIFormFile
{
    public static IFormFile GetFileMock(string contentType, string content)
    {
        var bytes = Encoding.UTF8.GetBytes(content);

        var file = new FormFile(
            baseStream: new MemoryStream(bytes),
            baseStreamOffset: 0,
            length: bytes.Length,
            name: "Data",
            fileName: "test.csv"
        )
        {
            Headers = new HeaderDictionary(),
            ContentType = contentType
        };

        return file;
    }
}
