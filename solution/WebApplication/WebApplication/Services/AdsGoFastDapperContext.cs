using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Policy;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using WebApplication.Models.Options;
using WebApplication.Services;

namespace WebApplication.Services
{
    public class AdsGoFastDapperContext 
    {
        private readonly AzureAuthenticationCredentialProvider _authProvider;
        private readonly string _connectionstring;
        private readonly bool _isUsingFullConnectionString;

        public AdsGoFastDapperContext(AzureAuthenticationCredentialProvider authProvider, IOptions<ApplicationOptions> options)
        {
            if (!string.IsNullOrEmpty(options.Value.ConnectionString))
            {
                _connectionstring = options.Value.ConnectionString;
                _isUsingFullConnectionString = true;
            }
            else
            {
                var scsb = new SqlConnectionStringBuilder
                {
                    DataSource = options.Value.AdsGoFastTaskMetaDataDatabaseServer,
                    InitialCatalog = options.Value.AdsGoFastTaskMetaDataDatabaseName
                };
                _connectionstring = scsb.ConnectionString;
            }

            _authProvider = authProvider;
        }

        public async Task<SqlConnection> GetConnection()
        {
            SqlConnection _con = new SqlConnection(_connectionstring);
            if (!_isUsingFullConnectionString)
            {
                string _token = await _authProvider.GetMsalRestApiToken(
                    new Azure.Core.TokenRequestContext(new string[] { "https://database.windows.net//.default" }),
                    new System.Threading.CancellationToken());
                _con.AccessToken = _token;
            }

            return _con;
        }
    }
}
