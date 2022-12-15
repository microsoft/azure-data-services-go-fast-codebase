namespace SecureFileUploader.Common.Interfaces;

public interface IByteConversionService
{
    double ConvertBytesToUnit(double bytes, string unit);
}
