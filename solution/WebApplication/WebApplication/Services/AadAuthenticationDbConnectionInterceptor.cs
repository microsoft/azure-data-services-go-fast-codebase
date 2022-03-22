using Azure.Core;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Diagnostics;
using System;
using System.Data.Common;
using System.Threading;
using System.Threading.Tasks;

namespace WebApplication.Services
{
    public class AadAuthenticationDbConnectionInterceptor : DbConnectionInterceptor
    {
        private readonly AzureAuthenticationCredentialProvider _azureAuthenticationCredentialProvider;

        public AadAuthenticationDbConnectionInterceptor(AzureAuthenticationCredentialProvider azureAuthenticationCredentialProvider)
        {
            _azureAuthenticationCredentialProvider = azureAuthenticationCredentialProvider;
        }

        public override InterceptionResult ConnectionOpening(DbConnection connection,
            ConnectionEventData eventData,
            InterceptionResult result)
        {
            var sqlConnection = (SqlConnection)connection;
            var ct = new CancellationToken();
            sqlConnection.AccessToken = GetAzureSqlAccessToken(ct).Result;
            return base.ConnectionOpening(connection, eventData, result);
        }

        public override async Task<InterceptionResult> ConnectionOpeningAsync(
            DbConnection connection,
            ConnectionEventData eventData,
            InterceptionResult result,
            CancellationToken cancellationToken)
        {
            var sqlConnection = (SqlConnection)connection;
            sqlConnection.AccessToken = await GetAzureSqlAccessToken(cancellationToken);
            return await base.ConnectionOpeningAsync(connection, eventData, result, cancellationToken);
        }

        private async Task<string> GetAzureSqlAccessToken(CancellationToken cancellationToken)
        {
            var tokenRequestContext = new TokenRequestContext(new[] { "https://database.windows.net//.default" });
            var tokenRequestResult = await _azureAuthenticationCredentialProvider.GetMsalRestApiToken(tokenRequestContext, cancellationToken);

            return tokenRequestResult;
        }
    }
}
