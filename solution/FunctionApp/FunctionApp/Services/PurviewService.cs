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
using FunctionApp.DataAccess;

namespace FunctionApp.Services
{
    public class PurviewService
    {
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly IOptions<ApplicationOptions> _options;
        private readonly IHttpClientFactory _httpClientFactory;

        public PurviewService(IAzureAuthenticationProvider authProvider, IOptions<ApplicationOptions> options, IHttpClientFactory httpClientFactory)
        {
            _authProvider = authProvider;
            _options = options;
            _httpClientFactory = httpClientFactory;
        }
        public async Task<string> TestPurview(string PurviewAccountName, string Method,  string APIURIDomain, string APIURIPath, string APIVersion, JObject PostBody, Logging.Logging logging)
        {
            
            try
            {
                using var c = _httpClientFactory.CreateClient(HttpClients.PurviewHttpClientName);                                   
                var postContent = new StringContent(PostBody.ToString(), System.Text.Encoding.UTF8, "application/json");

                HttpResponseMessage response;
                if (Method.ToLower() == "get")
                {
                    response = c.GetAsync($"https://{PurviewAccountName}{APIURIDomain}{APIURIPath}?&api-version={APIVersion}").Result;
                }
                else
                {
                    response = c.PostAsync($"https://{PurviewAccountName}{APIURIDomain}{APIURIPath}?&api-version={APIVersion}", postContent).Result;
                }

                HttpContent responseContent = response.Content;
                var res = response.Content.ReadAsStringAsync().Result;
                return res;

            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception("Purview Test Failed"));
                throw;
            }

        }



    }
}
