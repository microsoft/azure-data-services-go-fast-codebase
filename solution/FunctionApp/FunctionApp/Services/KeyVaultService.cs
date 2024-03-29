﻿using Microsoft.Azure.Management.Synapse;
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
        public async Task<string> RetriveSecret(string SecretName, string KeyVaultURL, Logging.Logging logging)
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
    }
}
