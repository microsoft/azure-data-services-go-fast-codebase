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
using System.Linq;
using FunctionApp.Functions;
using FunctionApp.DataAccess;
using System.IO;
using Microsoft.PowerBI.Api;
using Microsoft.Identity.Client;
using System.Threading;

namespace FunctionApp.Services
{
    public class PowerBIService
    {
        private readonly MicrosoftAzureServicesAppAuthenticationProvider _authProvider;
        private readonly IOptions<FunctionApp.Models.Options.ApplicationOptions> _options;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly KeyVaultService _keyVaultService;

        public PowerBIService(MicrosoftAzureServicesAppAuthenticationProvider authProvider, IOptions<FunctionApp.Models.Options.ApplicationOptions> options, TaskMetaDataDatabase taskMetaDataDatabase, KeyVaultService keyVaultService)
        {
            _authProvider = authProvider;
            _options = options;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _keyVaultService = keyVaultService;
        }
        public async Task<String> RefreshDataflow(string ClientId, string SecretName, string TenantId, string DataflowName, string WorkspaceId, string KeyVaultURL, Logging.Logging logging)
        {
            try
            {
                // get secret from keyvault using secretName
                var secret = await _keyVaultService.RetrieveSecret(SecretName, KeyVaultURL, logging);
                // Make a client call if Access token is not available in cache
                var authenticationResult = await _authProvider.GetPowerBIRestApiToken(ClientId, secret, TenantId);

                TokenCredentials tokenCredentials = new TokenCredentials(authenticationResult, "Bearer");


                //the request requires a 'Refresh Request' stating 'yes'
                Microsoft.PowerBI.Api.Models.RefreshRequest refreshRequest;
                refreshRequest = new Microsoft.PowerBI.Api.Models.RefreshRequest("y");

                //defining the powerBI client with our token
                PowerBIClient powerBIClient = new PowerBIClient(new Uri("https://api.powerbi.com"), tokenCredentials);

                //defining our workspace / setting a blank guid for dataflowid 
                Guid workspaceId = Guid.Parse(WorkspaceId);
                Guid dataflowId;


                logging.LogInformation($"Attempting to find: {DataflowName}");
                try
                {
                    var dataflows = await powerBIClient.Dataflows.GetDataflowsAsync(workspaceId);
                    var dataflow = dataflows.Value.FirstOrDefault(x => x.Name == DataflowName);
                    dataflowId = dataflow.ObjectId;

                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured finding: {DataflowName}");
                    logging.LogErrors(error);
                    logging.LogErrors(e);

                    throw error;
                }
                logging.LogInformation($"Attempting to refresh dataflow: {DataflowName}");
                try
                {
                    //await powerBIClient.Dataflows.RefreshDataflowAsync(workspace, dataflowId);
                    var preDataFlows = await powerBIClient.Dataflows.GetDataflowTransactionsAsync(workspaceId, dataflowId);
                    //var test = await powerBIClient.Dataflows.GetDataflowTransactionsWithHttpMessagesAsync(workspaceId, dataflowId);

                    var target = preDataFlows.Value[0].Id;
                    //if this is waiting until the refresh is complete we may want to remove the 'await'
                    await powerBIClient.Dataflows.RefreshDataflowAsync(workspaceId, dataflowId, refreshRequest);
                    //var t = await powerBIClient.Dataflows.RefreshDataflowWithHttpMessagesAsync(workspaceId, dataflowId, refreshRequest);
                    //We want to sleep so that the transactions have time to update.
                    Thread.Sleep(1200);
                    var postDataflows = await powerBIClient.Dataflows.GetDataflowTransactionsAsync(workspaceId, dataflowId);
                    int max = postDataflows.Value.Count;
                    string transactionId = "";
                    for (int i = 0; i < max; i++)
                    {
                        if (postDataflows.Value[i].Id == target)
                        {
                            try
                            {
                                transactionId = postDataflows.Value[i - 1].Id;
                            }
                            catch (Exception e)
                            {
                                Exception error = new Exception($"Error has occured obtaining transaction ID of the dataflow refresh {DataflowName}. Most likely obtained a -1 array index.");
                                logging.LogErrors(error);
                                logging.LogErrors(e);
                                throw error;
                            }
                        }
                    }
                    logging.LogInformation($"Dataflow {DataflowName} refresh has begun. Transaction ID for refresh is {transactionId}");
                    return transactionId;
                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured refreshing dataflow: {DataflowName}");
                    logging.LogErrors(error);
                    logging.LogErrors(e);
                    throw error;
                }

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Initiation of Dataflow Refresh command failed for DataflowId: {DataflowName} and Workspace: {WorkspaceId}"));
                throw;

            }
        }

        public async Task<String> CheckDataflowRefreshStatus(string ClientId, string SecretName, string TenantId, string DataflowName, string WorkspaceId, string KeyVaultURL, string transactionID, Logging.Logging logging)
        {
            try
            {
                // get secret from keyvault using secretName
                var secret = await _keyVaultService.RetrieveSecret(SecretName, KeyVaultURL, logging);
                // Make a client call if Access token is not available in cache
                var authenticationResult = await _authProvider.GetPowerBIRestApiToken(ClientId, secret, TenantId);

                TokenCredentials tokenCredentials = new TokenCredentials(authenticationResult, "Bearer");


                //defining the powerBI client with our token
                PowerBIClient powerBIClient = new PowerBIClient(new Uri("https://api.powerbi.com"), tokenCredentials);

                //defining our workspace / setting a blank guid for dataflowid 
                Guid workspaceId = Guid.Parse(WorkspaceId);
                Guid dataflowId;


                logging.LogInformation($"Attempting to find: {DataflowName}");
                try
                {
                    var dataflows = await powerBIClient.Dataflows.GetDataflowsAsync(workspaceId);
                    var dataflow = dataflows.Value.FirstOrDefault(x => x.Name == DataflowName);
                    dataflowId = dataflow.ObjectId;

                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured finding: {DataflowName}");
                    logging.LogErrors(error);
                    logging.LogErrors(e);

                    throw error;
                }

                logging.LogInformation($"Attempting to check the {DataflowName} transaction status with ID {transactionID}");
                try
                {
                    var dataflows = await powerBIClient.Dataflows.GetDataflowTransactionsAsync(workspaceId, dataflowId);
                    int max = dataflows.Value.Count;
                    string currentStatus = "";
                    for (int i = 0; i < max; i++)
                    {
                        if (dataflows.Value[i].Id == transactionID)
                        {
                            currentStatus = dataflows.Value[i].Status;
                        }
                    } 
                    if (string.IsNullOrEmpty(currentStatus))
                    {
                        currentStatus = "Failed";
                        logging.LogInformation($"Dataflow {DataflowName} execution status updated to {currentStatus} as no matching transaction ID found for {transactionID}");

                    }
                    logging.LogInformation($"Dataflow {DataflowName} execution status is {currentStatus}");
                    string result = "{ 'Status': '" + currentStatus + "' }";
                    return result;
                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured attempting to check the transactions of the dataflow: {DataflowName}");
                    logging.LogErrors(error);
                    logging.LogErrors(e);
                    throw error;
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Checking Transactions command failed for Dataflow: {DataflowName} and Workspace: {WorkspaceId}"));
                throw;

            }
        }


    }

}
