using Microsoft.Azure.Management.Synapse;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using FunctionApp.Authentication;
using FunctionApp.Models.Options;
using Microsoft.Extensions.Options;
using Microsoft.Rest;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http;
using Azure.Analytics.Synapse.Artifacts;
using Azure.Core;
using Microsoft.Azure.Management.DataFactory.Models;

namespace FunctionApp.Services
{
    public class AzureSynapseService
    {
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly IOptions<ApplicationOptions> _options;

        public AzureSynapseService(IAzureAuthenticationProvider authProvider, IOptions<ApplicationOptions> options)
        {
            _authProvider = authProvider;
            _options = options;
        }
        public async Task StartStopSynapseSqlPool(string SubscriptionId, string ResourceGroupName, string SynapseWorkspaceName, string SynapsePoolName, string Action, Logging.Logging logging)
        {
                        try
            {
                string token = await _authProvider.GetAzureRestApiToken("https://management.azure.com/").ConfigureAwait(false);
                ServiceClientCredentials cred = new TokenCredentials(token);

                //https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Synapse/workspaces/{workspace-name}/sqlPools/{database-name}/pause?api-version=2019-06-01-preview

                SynapseManagementClient synapseManagementClient = new SynapseManagementClient(cred);
                synapseManagementClient.SubscriptionId = SubscriptionId;
                var sqlPool = synapseManagementClient.SqlPools.Get(ResourceGroupName, SynapseWorkspaceName, SynapsePoolName);
                logging.LogInformation($"Synapse SQL pool ({SynapsePoolName}) is currently: {sqlPool.Status}");
                if (sqlPool.Status == "Paused" || sqlPool.Status == "Pausing")
                {
                    if (Action.ToLower() == "start")
                    {
                        logging.LogInformation($"Attempting to {Action} ({SynapsePoolName})");
                        synapseManagementClient.SqlPools.Resume(ResourceGroupName, SynapseWorkspaceName, SynapsePoolName);
                        logging.LogInformation($"{SynapsePoolName} now has the status: {sqlPool.Status}");
                    }
                    else
                    {
                        Exception error = new Exception("Cannot execute a " + Action + " action on the dedicated pool " + SynapsePoolName + ". Current status of pool: " + sqlPool.Status);
                        logging.LogErrors(error);
                        throw error;
                    }

                }
                else if (sqlPool.Status == "Online" || sqlPool.Status == "Resuming")
                {
                    if (Action.ToLower() == "pause")
                    {
                        logging.LogInformation($"Attempting to {Action} ({SynapsePoolName})");
                        synapseManagementClient.SqlPools.Pause(ResourceGroupName, SynapseWorkspaceName, SynapsePoolName);
                        logging.LogInformation($"{SynapsePoolName} now has the status: {sqlPool.Status}");
                    }
                    else
                    {
                        Exception error = new Exception("Cannot execute a " + Action + " action on the dedicated pool " + SynapsePoolName + ". Current status of pool: " + sqlPool.Status);
                        logging.LogErrors(error);
                        throw error;
                    }
                }



            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception("Initiation of SQLPool command failed:"));
                throw;

            }
        } 

        public async Task<HttpContent> RunSynapsePipeline(Uri endpoint, string pipelineName, Dictionary<string, object> pipelineParams, Logging.Logging logging)
        {
            
            try
            {
                string token = await _authProvider.GetAzureRestApiToken("https://dev.azuresynapse.net").ConfigureAwait(false); 
                HttpClient c = new HttpClient();
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                JObject jsonContent = new JObject();
                jsonContent["TaskObject"] = JsonConvert.SerializeObject(pipelineParams["TaskObject"]);
                var postContent = new StringContent(jsonContent.ToString(), System.Text.Encoding.UTF8, "application/json");
                var response = c.PostAsync($"{endpoint.ToString()}/pipelines/{pipelineName}/createRun?api-version=2020-12-01", postContent).Result;
                HttpContent responseContent = response.Content;
                return responseContent;

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception("Initiation of pipeline Failed:"));
                throw;
            }

        }



    }
}
