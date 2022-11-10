using FluentAssertions;
using SecureFileUploader.Common.Services;

namespace SecureFileUploader.Common.Tests.Services;

public class ByteConversionServiceTests
{
    [Fact]
    public void WhenConvertingBytesToKiloBytes_ReturnsCorrectValue()
    {
        const int bytes = 1000;
        const int expected = 1;

        var byteConversionService = new ByteConversionService();

        var result = byteConversionService.ConvertBytesToUnit(bytes, "KB");

        result.Should().Be(expected);
    }

    [Fact]
    public void WhenConvertingBytesToMegaBytes_ReturnsCorrectValue()
    {
        const int bytes = 1000000;
        const int expected = 1;

        var byteConversionService = new ByteConversionService();

        var result = byteConversionService.ConvertBytesToUnit(bytes, "MB");

        result.Should().Be(expected);
    }

    [Fact]
    public void WhenConvertingBytesToGigaBytes_ReturnsCorrectValue()
    {
        const int bytes = 1000000000;
        const int expected = 1;

        var byteConversionService = new ByteConversionService();

        var result = byteConversionService.ConvertBytesToUnit(bytes, "GB");

        result.Should().Be(expected);
    }
}
