using ByteSizeLib;
using SecureFileUploader.Common.Interfaces;

namespace SecureFileUploader.Common.Services;

public class ByteConversionService : IByteConversionService
{
    public double ConvertBytesToUnit(double bytes, string unit)
    {
        switch (unit)
        {
            case "KB":
                return ByteSize.FromBytes(bytes).KiloBytes;
            case "MB":
                return ByteSize.FromBytes(bytes).MegaBytes;
            case "GB":
                return ByteSize.FromBytes(bytes).GigaBytes;
            default:
                return bytes;
        }
    }
}
