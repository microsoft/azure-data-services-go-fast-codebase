using System.Collections.Generic;
using System.Data.SqlClient;
using Azure.Core;
using Azure.Identity;
using DbUp.Engine.Transactions;
using DbUp.Support;

namespace DbUp.SqlServer
{
    /// <summary>Manages an Azure Sql Server database connection.</summary>
    public class AzureSqlConnectionManager : DatabaseConnectionManager
    {
        public AzureSqlConnectionManager(string connectionString)
            : base(new DelegateConnectionFactory((log, dbManager) =>
            {

                var tokenRequestContext = new TokenRequestContext(new[] { "https://database.windows.net//.default" });
                var defaultAzureCredentialOptions = new DefaultAzureCredentialOptions();
                // Excluded to support running on github actions linux runner
                defaultAzureCredentialOptions.ExcludeSharedTokenCacheCredential = true;
                var credential = new DefaultAzureCredential(defaultAzureCredentialOptions);
                
                var token = credential.GetTokenAsync(tokenRequestContext).Result.Token;

                var conn = new SqlConnection(connectionString)
                {
                    AccessToken = token
                };

                if (dbManager.IsScriptOutputLogged)
                    conn.InfoMessage += (sender, e) => log.WriteInformation($"{{0}}", e.Message);

                return conn;
            }))
        { }

        public override IEnumerable<string> SplitScriptIntoCommands(string scriptContents)
        {
            var commandSplitter = new SqlCommandSplitter();
            var scriptStatements = commandSplitter.SplitScriptIntoCommands(scriptContents);
            return scriptStatements;
        }
    }
}
