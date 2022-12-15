using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Newtonsoft.Json;
using SecureFileUploader.Functions.Dtos;

namespace SecureFileUploader.Functions.Extensions;

// Adapted from: https://tsuyoshiushio.medium.com/how-to-validate-request-for-azure-functions-e6488c028a41
public static class HttpExtensions
{
    public static async Task<HttpResponseBody<T>> GetBodyAsync<T>(this HttpRequest request)
    {
        var body = new HttpResponseBody<T>();
        var bodyString = await request.ReadAsStringAsync();

        body.Value = JsonConvert.DeserializeObject<T>(bodyString);
        var results = new List<ValidationResult>();
        // doesn't work for JsonRequired
        body.IsValid =
            Validator.TryValidateObject(body.Value, new ValidationContext(body.Value, null, null), results, true);
        body.ValidationResults = results;

        return body;
    }

    public static async Task<T> GetRequestFromBodyAsync<T>(this HttpRequest request)
    {
        var body = new HttpResponseBody<T>();
        var bodyString = await request.ReadAsStringAsync();

        return JsonConvert.DeserializeObject<T>(bodyString);
    }

    /// <summary>
    /// Clones a HttpRequestMessage instance
    /// </summary>
    /// <param name="request">The HttpRequestMessage to clone.</param>
    /// <returns>A copy of the HttpRequestMessage</returns>
    public static HttpRequestMessage Clone(this HttpRequestMessage request)
    {
        var clone = new HttpRequestMessage(request.Method, request.RequestUri)
        {
            Content = request.Content.Clone(),
            Version = request.Version
        };

        foreach (KeyValuePair<string, object> prop in request.Options)
        {
            clone.Options.Set(new HttpRequestOptionsKey<string>(prop.Key), prop.Value.ToString());
        }

        foreach (KeyValuePair<string, IEnumerable<string>> header in request.Headers)
        {
            clone.Headers.TryAddWithoutValidation(header.Key, header.Value);
        }

        return clone;
    }

    /// <summary>
    /// Clones a HttpContent instance
    /// </summary>
    /// <param name="content">The HttpContent to clone</param>
    /// <returns>A copy of the HttpContent</returns>
    public static HttpContent Clone(this HttpContent content)
    {
        if (content == null) return null;

        HttpContent clone;

        switch (content)
        {
            case StringContent sc:
                clone = new StringContent(sc.ReadAsStringAsync().Result);
                break;
            default:
                throw new Exception(
                    $"{content.GetType()} Content type not implemented for HttpContent.Clone extension method.");
        }

        clone.Headers.Clear();
        foreach (KeyValuePair<string, IEnumerable<string>> header in content.Headers)
        {
            clone.Headers.Add(header.Key, header.Value);
        }

        return clone;
    }
}
