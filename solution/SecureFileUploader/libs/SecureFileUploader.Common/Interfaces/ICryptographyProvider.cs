namespace SecureFileUploader.Common.Interfaces;

public interface ICryptographyProvider
{
    string EncryptString(string toEncrypt);

    string DecryptString(string toDecrypt);
}
