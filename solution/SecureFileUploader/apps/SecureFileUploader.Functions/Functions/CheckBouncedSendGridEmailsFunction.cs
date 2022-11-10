using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using NodaTime;
using SecureFileUploader.Common.Interfaces;

namespace SecureFileUploader.Functions.Functions;

public class CheckBouncedSendGridEmailsFunction
{
    private readonly INotificationService _notificationService;
    private readonly IClock _clock;
    private readonly ISendGridEmailService _sendGridEmailService;

    public CheckBouncedSendGridEmailsFunction(INotificationService notificationService, IClock clock,
        ISendGridEmailService sendGridEmailService)
    {
        _notificationService = notificationService;
        _clock = clock;
        _sendGridEmailService = sendGridEmailService;
    }

    [FunctionName(nameof(CheckBouncedSendGridEmailsFunction))]
    public async Task Run([TimerTrigger("%CheckBouncedSendGridCron%")] TimerInfo myTimer, ILogger log)
    {
        var toTime = _clock.GetCurrentInstant().ToDateTimeUtc();
        // Lets just check every minute, in reality people would prefer a quicker notification of bounces
        // than every 5 minutes.
        // -2 seconds to cover any edge cases on the time not aligning with the cron ever so slightly
        var fromTime = _clock.GetCurrentInstant().ToDateTimeUtc().AddMinutes(-1).AddSeconds(-2);

        // 1. Fetch bounces, could be cut up more eh
        var bounces = await _sendGridEmailService.FetchSendGridBouncesAsync(fromTime, toTime);

        if (bounces.Any())
        {
            log.LogInformation($"Found {bounces.Count} unique bounced address/es from SendGrid.");
            // 2. Save bounces
            var bounceModel = await _sendGridEmailService.SaveSendGridBounceEmailsAsync(bounces);

            if (!bounceModel.Any())
                return;

            log.LogInformation("Sending notification of {count} SendGrid bounces.", bounces.Count);
            // 3. Notify admin of bounces
            await _notificationService.SendBouncedEmailsNotification(bounceModel);

            var toPurge = bounceModel.Select(x => x.Email).ToList();
            log.LogInformation("Purging {count} email/s.", toPurge.Count);
            // 4. Purge the bounces once completed
            await _sendGridEmailService.PurgeSendGridBouncesAsync(toPurge);
        }
    }
}
