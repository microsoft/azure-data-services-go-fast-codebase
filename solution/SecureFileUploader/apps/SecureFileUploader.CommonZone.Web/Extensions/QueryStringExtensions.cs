using System.Web;

namespace SecureFileUploader.CommonZone.Web.Extensions;

public static class QueryStringExtensions
{
    /// <summary>
    /// Given an unencrypted querystring, decrypt it then parse it for:
    /// * accessToken
    /// * phnHostname
    /// * apiKey
    /// * programName
    /// </summary>
    /// <param name="unencryptedQueryString"></param>
    /// <returns>a Dictionary of the processed query string</returns>
    /// <exception cref="ArgumentException">If unable to process query string</exception>
    public static Dictionary<string, string?> ParseQueryString(this string unencryptedQueryString)
    {
        var dict = new Dictionary<string, string?>();
        if (unencryptedQueryString.Contains('&'))
        {
            // Sensible ampersand encoding
            var results = HttpUtility.ParseQueryString(unencryptedQueryString);
            dict.Add("accessToken", results["accessToken"]);
            dict.Add("phnHostname", results["phnHostname"]);
            dict.Add("apiKey", results["apiKey"]);
            dict.Add("programName", results["programName"]);
        }
        else
        {
            var split = unencryptedQueryString.Split(',');
            // We note the ampersands are replaced with commas under IIS, strange encoding
            // We don't mind nulls here either
            dict = split.Select(pair => pair.Split('=')).ToDictionary(newPair => newPair[0], newPair => newPair[1])!;
        }

        // Note: we don't mind if programName is missing
        if (!dict.ContainsKey("accessToken") || !dict.ContainsKey("phnHostname") || !dict.ContainsKey("apiKey"))
        {
            throw new ArgumentException("Unable to process query string", nameof(unencryptedQueryString));
        }

        return dict;
    }
}
