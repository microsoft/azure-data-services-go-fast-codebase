/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using FunctionApp.Authentication;
using FunctionApp.DataAccess;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Management.Compute.Fluent;
using Microsoft.Azure.Management.Fluent;
using Microsoft.Azure.Management.ResourceManager.Fluent.Core;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Functions
{
    public class PurviewTest
    {
        private readonly PurviewService _purviewService;
        private readonly ApplicationOptions _options;
        private Logging.Logging _funcAppLogger = new Logging.Logging();

        public PurviewTest(IOptions<ApplicationOptions> options, PurviewService purviewService)
        {
            _purviewService = purviewService;
            _options = options?.Value;
        }
        [FunctionName("PurviewTest")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req, ILogger log, ExecutionContext context)
        {
            var executionId = System.Guid.NewGuid();
            ActivityLogItem activityLogItem = new ActivityLogItem
            {
                LogSource = "AF",
                ExecutionUid = executionId
            };
            _funcAppLogger.InitializeLog(log, activityLogItem);
            JObject j = new JObject();
            return new OkObjectResult(_purviewService.TestPurview("adsgfpv", "get", ".purview.azure.com", "/account/collections", "2019-11-01-preview",j, _funcAppLogger).Result);


        }


      

    }
}
