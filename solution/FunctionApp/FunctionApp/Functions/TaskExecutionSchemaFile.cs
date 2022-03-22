/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.IO;
using System.Threading.Tasks;
using FunctionApp.Authentication;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.WindowsAzure.Storage.Auth;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Functions
{
    /// <summary>
    /// Persist Metadata JSON in Azure Blob or ADLS
    /// </summary>
    // ReSharper disable once UnusedMember.Global
    public class TaskExecutionSchemaFile
    {
        private readonly IOptions<ApplicationOptions> _options;
        private readonly IAzureAuthenticationProvider _authProvider;

        public TaskExecutionSchemaFile(IOptions<ApplicationOptions> options, IAzureAuthenticationProvider authProvider)
        {
            _options = options;
            _authProvider = authProvider;
        }

        [FunctionName("TaskExecutionSchemaFile")]
        public IActionResult Run(
            [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
            ILogger log, ExecutionContext context)
        {
            Guid executionId = context.InvocationId; ;
            FrameworkRunner frp = new FrameworkRunner(log, executionId);

            FrameworkRunnerWorkerWithHttpRequest worker = TaskExecutionSchemaFileCore;
            FrameworkRunnerResult result = frp.Invoke(req, "TaskExecutionSchemaFile", worker);
            if (result.Succeeded)
            {
                return new OkObjectResult(JObject.Parse(result.ReturnObject));
            }
            else
            {
                return new BadRequestObjectResult(new { Error = "Execution Failed...." });
            }

        }


        public async Task<JObject> TaskExecutionSchemaFileCore(HttpRequest req, Logging.Logging logging)
        {
            string requestBody = new StreamReader(req.Body).ReadToEndAsync().Result;
            JObject data = JsonConvert.DeserializeObject<JObject>(requestBody);
            return await TaskExecutionSchemaFileCore(data, logging);

        }

        public async Task<JObject> TaskExecutionSchemaFileCore(JObject data, Logging.Logging logging)
        {
            
            string storageAccountName = data["StorageAccountName"].ToString();
            string storageAccountContainer = data["StorageAccountContainer"].ToString();
            string relativePath = data["RelativePath"].ToString();

            if (relativePath.StartsWith("/")) { relativePath = relativePath.Remove(0, 1);  }

            string metadataType = data["MetadataType"].ToString();
            string sourceType = data["SourceType"].ToString();
            string targetType = data["TargetType"].ToString();

            string schemaFileName = data["SchemaFileName"].ToString();
            string schemaStructure;

            if (metadataType == "Parquet")
            {
                schemaStructure = data["Data"]["structure"].ToString();
            }
            else
            {
                schemaStructure = data["Data"]["value"].ToString();
            }

            storageAccountName = storageAccountName.Replace(".dfs.core.windows.net", "").Replace("https://", "").Replace(".blob.core.windows.net", "");
            TokenCredential storageToken = new TokenCredential(await _authProvider.GetAzureRestApiToken($"https://{storageAccountName}.blob.core.windows.net").ConfigureAwait(false));

            if (!(sourceType == "Azure Blob" && sourceType == "ADLS") && (metadataType == "Parquet"))
            {
                schemaFileName = schemaFileName.Replace(".json", ".parquetschema.json");
            }


            try
            {
                AzureBlobStorageService.UploadContentToBlob(schemaStructure, storageAccountName, storageAccountContainer, relativePath, schemaFileName, storageToken);
            }
            catch (Exception e)
            {
                logging.LogErrors(new Exception($"TaskExecutionSchemaFileCore failed to upload schema file to storage:{storageAccountName},{storageAccountContainer},{relativePath},{schemaFileName}"), logging.DefaultActivityLogItem);
                throw e;
            }
            JArray arr = (JArray)JsonConvert.DeserializeObject(schemaStructure);

            JObject root = SqlDataTypeHelper.CreateMappingBetweenSourceAndTarget(arr, sourceType, targetType, metadataType);

            return root;
        }

    }
}