using System.Threading;
using System.Threading.Tasks;
using Azure.Core;
using Azure.Identity;
using FunctionApp.Models.Options;

namespace FunctionApp.Authentication
{
    /// <summary>
    /// This class uses the Microsoft.Identity packages and is the preferred authentication method moving forward.
    /// </summary>
    public class AzureIdentityAuthenticationProvider : IAzureAuthenticationProvider
    {
        private readonly ApplicationOptions _appOptions;
        private readonly AuthOptions _authOptions;

        public AzureIdentityAuthenticationProvider(ApplicationOptions appOptions, AuthOptions authOptions)
        {
            _appOptions = appOptions;
            _authOptions = authOptions;
        }

        /// <summary>
        /// Returns a token to authenticate with Azure services
        /// </summary>
        /// <param name="resourceName"></param>
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
        public async Task<string> GetAzureRestApiToken(string resourceName)
        {
            TokenCredential credential;
            if (!_appOptions.UseMSI)
            {
                credential = new ClientSecretCredential(_authOptions.TenantId, _authOptions.ClientId, _authOptions.ClientSecret);
            }
            else
            {
                var defaultAzureCredentialOptions = new DefaultAzureCredentialOptions();
                credential = new DefaultAzureCredential(defaultAzureCredentialOptions);
            }

            var requestContext = new TokenRequestContext(new [] {resourceName});
            var result = await credential.GetTokenAsync(requestContext, new CancellationToken()).ConfigureAwait(false);

            return result.Token;
        }
    }

}
