using System;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data.Models;
using SecureFileUploader.Functions.Dtos;

namespace SecureFileUploader.Functions.Functions;

public class SettingsHttpTrigger
{
    private readonly IAccessTokenService _accessTokenService;
    private readonly ISettingsService _settingsService;

    public SettingsHttpTrigger(IAccessTokenService accessTokenService, ISettingsService settingsService)
    {
        _accessTokenService = accessTokenService;
        _settingsService = settingsService;
    }

    [FunctionName(nameof(SettingsHttpTrigger))]
    [OpenApiOperation(operationId: "settings", tags: new[] {"Application Settings"})]
    [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
    [OpenApiRequestBody(contentType: "application/json", bodyType: typeof(SettingsRequest),
        Required = true, Description = "Settings Request Data")]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json",
        bodyType: typeof(Settings), Description = "Successfully fetched Settings")]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.BadRequest, Description = "Invalid Settings Request")]
    public async Task<IActionResult> RunAsync(
        [HttpTrigger(AuthorizationLevel.Function, "get", Route = "settings")] HttpRequest req, ILogger log)
    {
        SettingsRequest settingsRequest;

        // 1. Check consistency of the request
        try
        {
            settingsRequest = ParseRequest(req);
            if (settingsRequest == null)
                return new BadRequestResult();
        }
        catch (Exception)
        {
            // something wrong with the request, no need to be too verbose
            return new BadRequestResult();
        }

        // 2. Validate Token
        var token = await _accessTokenService.ValidateToken(settingsRequest.AccessToken);
        if (token is null)
        {
            return new UnauthorizedResult();
        }

        // 3. Fetch the settings
        var settings = await _settingsService.GetAllCurrentSettingsForProgramAsync(token.Invitee.Program.Id);

        return new OkObjectResult(settings);
    }

    private static SettingsRequest ParseRequest(HttpRequest request)
    {
        var dict = HttpUtility.ParseQueryString(request.QueryString.Value);
        var accessToken = dict["accessToken"];

        if (string.IsNullOrEmpty(accessToken))
            return null;

        return new SettingsRequest {
            AccessToken = Guid.Parse(accessToken)
        };
    }
}
