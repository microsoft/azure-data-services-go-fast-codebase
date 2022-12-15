using System.Web;
using FluentAssertions;
using SecureFileUploader.Common.Services;

namespace SecureFileUploader.Common.Tests.Services;

public class CryptographyProviderTests
{
    private const string ToEncrypt = "encryptMe";

    [Fact]
    public void WhenStringEncrypted_itsEncrypted()
    {
        var crypto = new CryptographyProvider();
        var result = crypto.EncryptString(ToEncrypt);

        // result will be encrypted nad base64
        result.Should().NotBeEquivalentTo(ToEncrypt);
        // Since it is base64 - check it really is encrypted
        Convert.FromBase64String(result).Should().NotBeEquivalentTo(ToEncrypt);
    }

    [Fact]
    public void WhenDecryptAString_itsInPlainText()
    {
        var crypto = new CryptographyProvider();
        var encrypted = crypto.EncryptString(ToEncrypt);

        // Check what goes in - must come out
        crypto.DecryptString(encrypted).Should().BeEquivalentTo(ToEncrypt);
    }

    [Fact]
    public void WhenInputIsNotBase64_throwsException()
    {
        var crypto = new CryptographyProvider();

        Assert.Throws<FormatException>(() => crypto.DecryptString("some_string"));
    }

    [Fact]
    public void WhenDecryptAString_KeepsAmpersands()
    {
        // This test is for my sanity - it appears something strange happens
        // where ampersands are replaced with commas possibly due to IIS
        var crypto = new CryptographyProvider();

        var expectedResult =$"phnHostname=http://some-server.com&accessToken={new Guid()}&apiKey={new Guid()}";
        var encrypted = crypto.EncryptString(expectedResult);

        var encoded = HttpUtility.UrlEncode(encrypted);
        var decoded = HttpUtility.UrlDecode(encoded);

        decoded.Should().Be(encrypted);
        crypto.DecryptString(decoded).Should().BeEquivalentTo(expectedResult);

        crypto.DecryptString(encrypted).Should().BeEquivalentTo(expectedResult);
    }
}
