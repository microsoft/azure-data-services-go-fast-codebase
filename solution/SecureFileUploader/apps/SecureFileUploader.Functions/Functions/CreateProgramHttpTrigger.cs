using System;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Models;
using SecureFileUploader.Functions.Dtos;
using SecureFileUploader.Functions.Extensions;

namespace SecureFileUploader.Functions.Functions;

public class CreateProgramHttpTrigger
{
    private readonly ICreateProgramService _createProgramService;
    private readonly SecureFileUploaderContext _context;
    private const string GenericFailureMessage = "Failed to create program";

    public CreateProgramHttpTrigger(ICreateProgramService createProgramService, SecureFileUploaderContext context)
    {
        _createProgramService = createProgramService;
        _context = context;
    }

    [FunctionName(nameof(CreateProgramHttpTrigger))]
    [OpenApiOperation(operationId: "CreateProgram", tags: new[] {"Create Program"})]
    [OpenApiRequestBody(contentType: "application/json", bodyType: typeof(CreateProgramRequest), Required = true,
        Description = "Create Program Data")]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json",
        bodyType: typeof(CreateProgramRequest), Description = "Program Created with Invitees")]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.BadRequest, Description = "Request body is empty")]
    public async Task<IActionResult> RunAsync(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "program")]
        HttpRequest req, ILogger log)
    {
        CreateProgramRequest requestData;
        Program program;
        try
        {
            requestData = await req.GetRequestFromBodyAsync<CreateProgramRequest>();

            if (requestData == null)
            {
                return new BadRequestObjectResult("Request body is empty");
            }

            var inviteeErrors = ValidationService.ValidateInvitee(requestData.Invitees);

            if (inviteeErrors.ErrorMessage.Count > 0)
            {
                return new BadRequestObjectResult(inviteeErrors);
            }

            var programErrors = ValidationService.ValidateProgram(requestData.Program);

            if (programErrors.ErrorMessage.Count > 0)
            {
                return new BadRequestObjectResult(programErrors);
            }
        }
        catch (JsonReaderException ex)
        {
            return new BadRequestObjectResult(ex.Message);
        }
        catch (JsonSerializationException ex)
        {
            return new BadRequestObjectResult(ex.Message);
        }

        try
        {
            requestData.Program.TimeZone = "UTC";

            program = await _createProgramService.InsertProgramData(requestData.Program);
            await _createProgramService.InsertInviteeData(requestData.Invitees, program);
            await _context.SaveChangesAsync();
        }
        catch (Exception)
        {
            return new BadRequestObjectResult(GenericFailureMessage);
        }

        return new OkObjectResult(new CreateProgramResponse {
            ProgramId = program.Id
        });
    }
}
