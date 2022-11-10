using System.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.WebUtilities;
using Newtonsoft.Json;
using SecureFileUploader.CommonZone.Web.Extensions;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.CommonZone.Web.Dtos;
using SecureFileUploader.CommonZone.Web.Models;

namespace SecureFileUploader.CommonZone.Web.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UploadController : ControllerBase
    {
        private readonly ILogger<UploadController> _logger;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ICryptographyProvider _cryptographyProvider;
        private readonly IByteConversionService _byteConversion;
        private const string PhnHostnameKey = "phnHostname";
        private const string AccessToken = "accessToken";

        public UploadController(ILogger<UploadController> logger, IHttpClientFactory httpClientFactory,
            ICryptographyProvider cryptographyProvider, IByteConversionService byteConversion)
        {
            _logger = logger;
            _httpClientFactory = httpClientFactory;
            _cryptographyProvider = cryptographyProvider;
            _byteConversion = byteConversion;
        }

        /// <summary>
        /// Accept a FileUpload from a front end form. Makes a further call to a downstream API.
        /// </summary>
        /// <param name="fileUpload">FileUpload object to be sent to a downstream API</param>
        /// <returns>No Content</returns>
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [DisableRequestSizeLimit]
        public async Task<IActionResult> Post([FromForm] FileUpload fileUpload)
        {
            if (!ModelState.IsValid) return BadRequest("Invalid request - missing parameters.");

            // unencoded at this point thanks to the webserver
            var queryStringDictionary = _cryptographyProvider.DecryptString(fileUpload.QueryString).ParseQueryString();
            var settings = await FetchCurrentSettings(queryStringDictionary);

            if (fileUpload.File.Length == 0) return BadRequest("The File must not be empty.");

            var fileSize = _byteConversion.ConvertBytesToUnit(fileUpload.File.Length, settings.FileUnit);

            if (settings.MinFileSize != 0)
            {
                if (fileSize < settings.MinFileSize)
                    return BadRequest($"The File must be at least {settings.MinFileSize} {settings.FileUnit}.");
            }

            if (settings.MaxFileSize != 0)
            {
                if (fileSize > settings.MaxFileSize)
                    return BadRequest($"The File must be less than {settings.MaxFileSize} {settings.FileUnit}.");
            }

            var fileExtension = Path.GetExtension(fileUpload.File.FileName.ToLower());
            switch (fileExtension)
            {
                case ".csv":
                    if (!settings.AllowCsvFiles) return BadRequest("CSV files are not allowed.");
                    break;
                case ".json":
                    if (!settings.AllowJsonFiles) return BadRequest("JSON files are not allowed.");
                    break;
                case ".zip":
                    if (!settings.AllowZippedFiles) return BadRequest("Zipped files are not allowed.");
                    break;
                default:
                    return BadRequest("File type is not allowed");
            }

            await UploadFileToPhnAsync(fileUpload.File, queryStringDictionary);

            return NoContent();
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> Get()
        {
            const string unknownProgram = "Welcome to the PIP QI Uploader";
            if (string.IsNullOrEmpty(Request.QueryString.Value))
            {
                // Useful for people who received an invite before we applied this change
                return Ok(new UploadModel {
                    ProgramName = unknownProgram
                });
            }

            var queryStringDictionary =
                _cryptographyProvider.DecryptString(
                    Request.QueryString.Value.TrimStart('?')).ParseQueryString();

            var settings = await FetchCurrentSettings(queryStringDictionary);

            return Ok(new UploadModel {
                ProgramName = queryStringDictionary["programName"] ?? unknownProgram,
                MaxFileSize = settings.MaxFileSize,
                MinFileSize = settings.MinFileSize,
                FileSizeUnits = settings.FileUnit,
                AllowedFileTypes = new AllowedFileTypes {
                    AllowCsv = settings.AllowCsvFiles,
                    AllowJson = settings.AllowJsonFiles,
                    AllowZip = settings.AllowZippedFiles
                },
                PhnLogo = settings.PhnLogo ?? string.Empty
            });
        }

        /// <summary>
        /// Upload a file down a downstream Phn API
        /// </summary>
        /// <param name="file">A file to upload</param>
        /// <param name="queryStringDictionary">Query string as dictionary</param>
        /// <exception cref="ArgumentException">If an accesskey/phnHostname/apiKey combo is not present</exception>
        private async Task
            UploadFileToPhnAsync(IFormFile file, IReadOnlyDictionary<string, string?> queryStringDictionary)
        {
            using var multipartFormContent = new MultipartFormDataContent();

            multipartFormContent.Add(new StringContent(queryStringDictionary[AccessToken]!), "AccessToken");

            await using var fileStream = file.OpenReadStream();
            using var fileStreamContent = new StreamContent(fileStream);
            fileStreamContent.Headers.ContentType = MediaTypeHeaderValue.Parse("application/json");

            multipartFormContent.Add(fileStreamContent, "File", file.FileName);

            var phnHostname = queryStringDictionary[PhnHostnameKey];
            if (!phnHostname!.EndsWith("/"))
            {
                phnHostname += "/";
            }

            var query = new Dictionary<string, string?> {
                // Note: not useful locally, will be ignored
                // Now we remember code is the query string attribute to execute an azure function
                ["code"] = queryStringDictionary["apiKey"]
            };

            var client = _httpClientFactory.CreateClient();
            var response =
                await client.PostAsync(
                    QueryHelpers.AddQueryString($"{phnHostname}api/upload", query),
                    multipartFormContent);

            response.EnsureSuccessStatusCode();
        }

        /// <summary>
        /// Fetch the program/application settings
        /// </summary>
        /// <param name="queryStringDictionary">Query string as dictionary</param>
        /// <returns>Program/Application settings</returns>
        /// <exception cref="Exception"></exception>
        private async Task<Settings> FetchCurrentSettings(IReadOnlyDictionary<string, string?> queryStringDictionary)
        {
            var phnHostname = queryStringDictionary[PhnHostnameKey];
            if (!phnHostname!.EndsWith("/"))
            {
                phnHostname += "/";
            }

            var query = new Dictionary<string, string?> {
                // Note: not useful locally, will be ignored
                // Now we remember code is the query string attribute to execute an azure function
                ["code"] = queryStringDictionary["apiKey"],
                [AccessToken] = queryStringDictionary[AccessToken]
            };

            var client = _httpClientFactory.CreateClient();
            var response =
                await client.GetAsync(
                    QueryHelpers.AddQueryString($"{phnHostname}api/settings", query));

            response.EnsureSuccessStatusCode();

            var settings = JsonConvert.DeserializeObject<Settings>(await response.Content.ReadAsStringAsync());
            if (settings == null)
            {
                throw new BadHttpRequestException("Unable to read Settings");
            }

            return settings;
        }
    }
}
