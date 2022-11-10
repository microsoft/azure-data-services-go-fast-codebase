using Microsoft.Azure.Management.DataFactory;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Extensions.Options;
using Microsoft.Rest;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Settings;

namespace SecureFileUploader.Common.Services
{
    public class PipelineService : IPipelineService
    {
        private readonly AdsSettings _adsSettings;

        public PipelineService(IOptions<AdsSettings> adsSettingsAccessor)
        {
            _adsSettings = adsSettingsAccessor.Value;
        }

        private DataFactoryManagementClient CreateDataFactoryManagementClient(string subscriptionId, string tenantId)
        {
            // AzureServiceTokenProvider uses developer credentials when running locally
            // and uses managed identity when deployed to Azure.
            // If getting an exception when running locally, run "az login" command in Azure CLI
            var provider = new AzureServiceTokenProvider();
            var token = provider.GetAccessTokenAsync("https://management.azure.com", tenantId).Result;
            ServiceClientCredentials credentials = new TokenCredentials(token);

            var client = new DataFactoryManagementClient(credentials);
            client.SubscriptionId = subscriptionId;
            return client;
        }

        private async Task<string> TriggerPipeline(string subscriptionId, string tenantId, string resourceGroupName, string dataFactoryName, string pipelineName, IDictionary<string, object> parameters)
        {
            var dataFactoryManagementClient = CreateDataFactoryManagementClient(subscriptionId, tenantId);
            var run = await dataFactoryManagementClient.Pipelines.CreateRunWithHttpMessagesAsync(resourceGroupName, dataFactoryName, pipelineName, parameters: parameters);
            return run.Body.RunId;
        }

        public async Task<string> TriggerTransInToBronzePipeline(string sourceFile)
        {
            if (_adsSettings.UseADS)
            {
                var parameters = new Dictionary<string, object> {
                    { "SourceStore_Directory", sourceFile },
                    { "DestinationStore_Directory", sourceFile }
                };

                return await TriggerPipeline(_adsSettings.SubscriptionId, _adsSettings.TenantId, _adsSettings.ResourceGroup, _adsSettings.DataFactoryName, _adsSettings.PipelineName, parameters);
            }

            return string.Empty;
        }
    }
}
