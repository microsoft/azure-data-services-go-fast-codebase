using Azure.Core;
using Azure.Identity;
using Microsoft.Extensions.Options;
using Microsoft.Identity.Web;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using System;
using System.Threading;
using System.Threading.Tasks;
using WebApplication.Models.Options;

namespace WebApplication.Services
{
    public class AzureAuthenticationCredentialProvider
    {
        private readonly IOptions<ApplicationOptions> _appOptions;
        private readonly IOptions<AuthOptions> _authOptions;

        public AzureAuthenticationCredentialProvider(IOptions<ApplicationOptions> appOptions, IOptions<AuthOptions> authOptions)
        {
            _appOptions = appOptions;
            _authOptions = authOptions;
        }

        /// <summary>
        /// ### Not using this at the moment. Have fallen back to GetAzureRestApiToken as it supports both Service Principal and MSI. ClientSecretCredential only supports .default scope so we have included this ADAL method of getting a token using ClientCreds.
        /// this allows us to access AppInsights using it's custom scope requirement
        /// </summary>
        /// <param name="requestContext"></param>
        /// <param name="cancellationToken"></param>
        /// <returns></returns>
        public async Task<string> GetAdalRestApiToken(TokenRequestContext requestContext, CancellationToken cancellationToken)
        {
            try
            {
                AuthenticationContext context = new AuthenticationContext("https://login.windows.net/" + _authOptions.Value.TenantId);
                ClientCredential cc = new ClientCredential(_authOptions.Value.ClientId, _authOptions.Value.ClientSecret);
                AuthenticationResult result = await context.AcquireTokenAsync(requestContext.Scopes[0], cc);
                return result.AccessToken;
            }
            catch(Exception ex)
            {
                throw;
            }
            
        }

        /// <summary>
        /// Returns a token to authenticate with Azure services
        /// </summary>
        /// <param name="serviceUri"></param>
        /// <returns>An access token for the requested endpoint/scope</returns>
        /// <remarks>
        /// If the web application is configured with ClientId and Secret using the standard MicrosoftIdentityOptions
        /// Then ClientCredentials are used to provide the identity requesting a token otherwise it will fall through to use
        /// an DefaultAzureCredential object. The following credential types if enabled will be tried, in order:
        /// - EnvironmentCredential
        /// - ManagedIdentityCredential
        /// - SharedTokenCacheCredential
        /// - VisualStudioCredential
        /// - VisualStudioCodeCredential
        /// - AzureCliCredential
        /// - InteractiveBrowserCredential
        /// </remarks>
        public async Task<string> GetMsalRestApiToken(TokenRequestContext requestContext, CancellationToken cancellationToken)
        {
            TokenCredential credential = null;
            if (!string.IsNullOrEmpty(_authOptions.Value.ClientSecret))
            {
                credential = new ClientSecretCredential(_authOptions.Value.TenantId, _authOptions.Value.ClientId, _authOptions.Value.ClientSecret);
            }
            else
            {
                var defaultAzureCredentialOptions = new DefaultAzureCredentialOptions()
                {
                    ExcludeAzureCliCredential = true,
                    ExcludeManagedIdentityCredential = !_appOptions.Value.UseMSI
                };
                credential = new DefaultAzureCredential(defaultAzureCredentialOptions);
            }

            var result = await credential.GetTokenAsync(requestContext, cancellationToken);

            return result.Token;
        }

        /// <summary>
        /// Manual method of failing back through authentication options. Used to support AppInsights connectivity as GetMsalRestApiToken only supports a default scope.
        /// </summary>
        /// <param name="ServiceURI"></param>
        /// <returns></returns>
        public string GetAzureRestApiToken(string ServiceURI)
        {
            if (_appOptions.Value.UseMSI)
            {
                return GetAzureRestApiToken(ServiceURI, _appOptions.Value.UseMSI, null, null);
            }
            else
            {
                //By Default Use Local SP Credentials
                return GetAzureRestApiToken(ServiceURI, _appOptions.Value.UseMSI, _authOptions.Value.ClientId, _authOptions.Value.ClientSecret);
            }
        }

        public string GetAzureRestApiToken(string ServiceURI, bool UseMSI)
        {
            if (UseMSI)
            {
                return GetAzureRestApiToken(ServiceURI, UseMSI, null, null);
            }
            else
            {
                //By Default Use Local SP Credentials
                return GetAzureRestApiToken(ServiceURI, UseMSI, _authOptions.Value.ClientId, _authOptions.Value.ClientSecret);
            }
        }

        public string GetAzureRestApiToken(string ServiceURI, bool UseMSI, string ApplicationId, string AuthenticationKey)
        {
            if (UseMSI == true)
            {

                Microsoft.Azure.Services.AppAuthentication.AzureServiceTokenProvider tokenProvider = new Microsoft.Azure.Services.AppAuthentication.AzureServiceTokenProvider();
                //https://management.azure.com/                    
                return tokenProvider.GetAccessTokenAsync(ServiceURI).Result;

            }
            else
            {

                AuthenticationContext context = new AuthenticationContext("https://login.windows.net/" + _authOptions.Value.TenantId);
                ClientCredential cc = new ClientCredential(ApplicationId, AuthenticationKey);
                AuthenticationResult result = context.AcquireTokenAsync(ServiceURI, cc).Result;
                return result.AccessToken;
            }
        }
    }

}
