using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using WebApplication.Models.Options;
using WebApplication.Services;

namespace WebApplication.Models
{
    public class AppInsightsContext
    {
        private readonly HttpClient _httpClient;
        private readonly AzureAuthenticationCredentialProvider _authProvider;

        private readonly string _appInsightsWorkspaceId;

        public AppInsightsContext(IOptions<ApplicationOptions> applicationOptions, HttpClient httpClient, AzureAuthenticationCredentialProvider authProvider)
        {
            _appInsightsWorkspaceId = applicationOptions.Value.AppInsightsWorkspaceId;
            _httpClient = httpClient;
            _authProvider = authProvider;
        }

        public async Task<JArray> ExecuteQuery(string Query)
        {
            JObject JsonContent = new JObject();
            JsonContent["query"] = Query;
            var postContent = new StringContent(JsonContent.ToString(), System.Text.Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync($"https://api.applicationinsights.io/v1/apps/{_appInsightsWorkspaceId}/query", postContent);

            JArray tables = new JArray();
            if (response.StatusCode == System.Net.HttpStatusCode.OK)
            {
                var content = await response.Content.ReadAsStringAsync();
                tables = ((JArray)(JObject.Parse(content)["tables"]));
            }
            return tables;
        }
    }
}
