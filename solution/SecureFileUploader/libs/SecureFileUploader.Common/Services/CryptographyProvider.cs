using System.Security.Cryptography;
using SecureFileUploader.Common.Interfaces;

namespace SecureFileUploader.Common.Services;

public class CryptographyProvider : ICryptographyProvider
{
    // NOTE: These values should be stored in a Key Vault. Left here as an exercise for the implementor.
    // As a convenience the values are here also as the CommonZone.Web and Portal.Web projects need to make use of this class.
    // Suggest both apps have access to the same KeyVault...
    private static byte[] _iv = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
        0x07, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0E};
    private static byte[] _key = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
        0x89, 0x99, 0xAA, 0xBE, 0xCC, 0xDD, 0xEE, 0xFF };

    /// <summary>
    /// Take a string and Encrypt it, returning it in a base64 format.
    /// </summary>
    /// <param name="toEncrypt"></param>
    /// <returns>A base64 encoded string containing an encrypted string</returns>
    public string EncryptString(string toEncrypt)
    {
        using var myAes = Aes.Create();

        var encrypted = EncryptStringToBytes_Aes(toEncrypt, _key, _iv);
        return Convert.ToBase64String(encrypted);
    }

    /// <summary>
    /// For a base64 string - decrypt it and return the plaintext string.
    /// </summary>
    /// <param name="toDecrypt">A base64 string to decrypt</param>
    /// <returns>A plaintext decrypted string</returns>
    /// <exception cref="FormatException">If input string is not base64</exception>
    public string DecryptString(string toDecrypt)
    {
        using var myAes = Aes.Create();
        return DecryptStringFromBytes_Aes(Convert.FromBase64String(toDecrypt), _key, _iv);
    }

    // Adapted from https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=net-6.0
    private static byte[] EncryptStringToBytes_Aes(string plainText, byte[] key, byte[] iv)
    {
        // Check arguments.
        if (plainText == null || plainText.Length <= 0)
            throw new ArgumentNullException("plainText");
        if (key == null || key.Length <= 0)
            throw new ArgumentNullException("key");
        if (iv == null || iv.Length <= 0)
            throw new ArgumentNullException("iv");
        byte[] encrypted;

        // Create an Aes object
        // with the specified key and IV.
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = key;
            aesAlg.IV = iv;

            // Create an encryptor to perform the stream transform.
            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            // Create the streams used for encryption.
            using (MemoryStream msEncrypt = new MemoryStream())
            {
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                    {
                        //Write all data to the stream.
                        swEncrypt.Write(plainText);
                    }
                    encrypted = msEncrypt.ToArray();
                }
            }
        }

        // Return the encrypted bytes from the memory stream.
        return encrypted;
    }

    // Adapted from https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=net-6.0
    private static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
    {
        // Check arguments.
        if (cipherText == null || cipherText.Length <= 0)
            throw new ArgumentNullException("cipherText");
        if (Key == null || Key.Length <= 0)
            throw new ArgumentNullException("Key");
        if (IV == null || IV.Length <= 0)
            throw new ArgumentNullException("IV");

        // Declare the string used to hold
        // the decrypted text.
        string plaintext = null;

        // Create an Aes object
        // with the specified key and IV.
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = Key;
            aesAlg.IV = IV;

            // Create a decryptor to perform the stream transform.
            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            // Create the streams used for decryption.
            using (MemoryStream msDecrypt = new MemoryStream(cipherText))
            {
                using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                    {
                        // Read the decrypted bytes from the decrypting stream
                        // and place them in a string.
                        plaintext = srDecrypt.ReadToEnd();
                    }
                }
            }
        }

        return plaintext;
    }
}
