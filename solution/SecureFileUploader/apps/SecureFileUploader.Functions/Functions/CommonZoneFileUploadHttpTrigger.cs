using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Functions.Dtos;

namespace SecureFileUploader.Functions.Functions;

public class CommonZoneFileUploadHttpTrigger
{
    private readonly IAccessTokenService _tokenService;
    private readonly IInviteeService _inviteeService;
    private readonly IStorageService _storageService;
    private readonly INotificationService _notificationService;
    private readonly IPipelineService _pipelineService;

    public CommonZoneFileUploadHttpTrigger(
        IAccessTokenService tokenService,
        IInviteeService inviteeService,
        IStorageService storageService,
        INotificationService notificationService,
        IPipelineService pipelineService)
    {
        _tokenService = tokenService;
        _inviteeService = inviteeService;
        _storageService = storageService;
        _notificationService = notificationService;
        _pipelineService = pipelineService;
    }

    [FunctionName(nameof(CommonZoneFileUploadHttpTrigger))]
    [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = int.MaxValue)]
    public async Task<IActionResult> RunAsync(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "upload")]
        HttpRequest req, ILogger log)
    {
        CommonZoneFileUpload uploadRequest;

        // Check consistency of the request
        try
        {
            uploadRequest = await ParseRequest(req);
        }
        catch (Exception)
        {
            // something wrong with the request, no need to be too verbose
            return new BadRequestResult();
        }

        // We don't have to have the invitee information here, so fetch what is attached to the Token
        var token = await _tokenService.ValidateToken(uploadRequest.AccessToken);
        if (token is null)
        {
            return new UnauthorizedResult();
        }

        // Save file to storage
        await using var fileStream = uploadRequest.File.OpenReadStream();
        var sourceFolder = await _storageService.UploadToTransientIn(fileStream,
            Path.GetExtension(uploadRequest.File.FileName) ?? string.Empty, token.InviteeId);

        // Invitee row should now be marked as having their file uploaded
        await _inviteeService.MarkInviteeFileUpload(token.InviteeId);

        // Send email to customer informing them of upload
        await _notificationService.SendFileUploadConfirmationAsync(token.InviteeId);

        // call pipeline to move file from transient in
        await _pipelineService.TriggerTransInToBronzePipeline(sourceFolder);

        return new NoContentResult();
    }

    private static async Task<CommonZoneFileUpload> ParseRequest(HttpRequest req)
    {
        var result = new CommonZoneFileUpload();

        var form = await req.ReadFormAsync();
        // We don't mind throwing an error here
        result.AccessToken = new Guid(form["AccessToken"]);

        using var ms = new MemoryStream();
        var formFile = req.Form.Files["File"];
        await formFile.CopyToAsync(ms);
        ms.Seek(0, SeekOrigin.Begin);

        result.File = formFile;

        return result;
    }
}
