using System;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Functions.Interfaces;

namespace SecureFileUploader.Functions.Functions;

public class CommenceProgramFunction
{
    private readonly IAccessTokenService _accessTokenService;
    private readonly INotificationService _notificationService;
    private readonly IProgramCommencementCheckService _programCommencementCheckService;

    public CommenceProgramFunction(
        IProgramCommencementCheckService programCommencementCheckService,
        IAccessTokenService accessTokenService,
        INotificationService notificationService)
    {
        _programCommencementCheckService = programCommencementCheckService;
        _accessTokenService = accessTokenService;
        _notificationService = notificationService;
    }

    [FunctionName(nameof(CommenceProgramFunction))]
    public async Task Run([TimerTrigger("%CommenceProgramCron%")] TimerInfo myTimer, ILogger log)
    {
        await _programCommencementCheckService.MarkProgramCommencementAsync(DateTime.UtcNow);
        await _accessTokenService.GenerateForCommencedProgramsAsync();
        await _notificationService.SendAllPendingInvitesAsync();
    }
}
