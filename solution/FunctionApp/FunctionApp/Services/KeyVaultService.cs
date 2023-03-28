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
using Azure.Security.KeyVault.Secrets;
using Microsoft.Identity.Client;

namespace FunctionApp.Services
{
    public class KeyVaultService
    {
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly IOptions<FunctionApp.Models.Options.ApplicationOptions> _options;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;

        public KeyVaultService(IAzureAuthenticationProvider authProvider, IOptions<FunctionApp.Models.Options.ApplicationOptions> options, TaskMetaDataDatabase taskMetaDataDatabase)
        {
            _authProvider = authProvider;
            _options = options;
            _taskMetaDataDatabase = taskMetaDataDatabase;
        }
        public async Task<string> RetrieveSecret(string SecretName, string KeyVaultURL, Logging.Logging logging)
        {
            try
            {
                // get secret from keyvault using secretName
                var cred = _authProvider.GetAzureRestApiTokenCredential("https://management.azure.com/");

                //var authenticationResult = await _authProvider.GetPowerBIRestApiToken(ClientId, secret);
                var client = new SecretClient(vaultUri: new Uri(KeyVaultURL), cred);
                //var client = new SecretClient(vaultUri: new Uri(KeyVaultURL), credential: cred);
                var secret = await client.GetSecretAsync(SecretName);
                var ret = secret.Value.Value;


                try
                {
                    logging.LogInformation($"Secret has been retrieved.");
                    return ret;
                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured retrieving secret: {SecretName} ");
                    logging.LogErrors(error);
                    throw error;
                }

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Initiation of Retrieve Secret command failed for Secretname: {SecretName} "));
                throw;

            }
        }

        public async Task<bool> CheckSecretExists(string SecretName, string KeyVaultURL, Logging.Logging logging)
        {
            try
            {
                // get secret from keyvault using secretName
                var cred = _authProvider.GetAzureRestApiTokenCredential("https://management.azure.com/");

                //var authenticationResult = await _authProvider.GetPowerBIRestApiToken(ClientId, secret);
                var client = new SecretClient(vaultUri: new Uri(KeyVaultURL), cred);
                //var client = new SecretClient(vaultUri: new Uri(KeyVaultURL), credential: cred);
                var secrets =  client.GetPropertiesOfSecretsAsync();
                //https://learn.microsoft.com/en-us/dotnet/api/azure.security.keyvault.secrets.secretproperties?view=azure-dotnet
                var secretFound = false;
                await foreach (SecretProperties secretProperty in secrets)
                {
                    if (secretProperty.Name == SecretName)
                    {
                        secretFound = true;
                        logging.LogInformation($"Secret found within key vault: {SecretName}");
                    }
                }


                try
                {
                    logging.LogInformation($"Secret Exists within KV? {secretFound}.");
                    return secretFound;
                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured finding secret: {SecretName} ");
                    logging.LogErrors(error);
                    throw error;
                }

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Initiation of Check Secret command failed for Secretname: {SecretName} "));
                throw;

            }
        }

        public async Task<bool> CreateSecret(string SecretName, string SecretValue, string KeyVaultURL, Logging.Logging logging)
        {
            try
            {
                // get secret from keyvault using secretName
                var cred = _authProvider.GetAzureRestApiTokenCredential("https://management.azure.com/");

                var client = new SecretClient(vaultUri: new Uri(KeyVaultURL), cred);
                var secret = await client.SetSecretAsync(SecretName, SecretValue);


                try
                {
                    logging.LogInformation($"Secret has been created.");
                    return true;
                }
                catch (Exception e)
                {
                    Exception error = new Exception($"Error has occured creating secret: {SecretName} ");
                    logging.LogErrors(error);
                    throw error;
                }

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Initiation of Create Secret command failed for Secretname: {SecretName} "));
                throw;

            }
        }

    }
}
