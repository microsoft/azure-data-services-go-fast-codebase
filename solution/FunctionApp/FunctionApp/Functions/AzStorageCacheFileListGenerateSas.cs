/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Table;
using Newtonsoft.Json;

namespace FunctionApp.Functions
{

    public static class AzStorageCacheFileListGenerateSas
    {
        /// <summary>
        /// Use this function to generate the SASURI for the StorageFileCache Tasks
        /// </summary>
        
        /// <returns></returns>
        [FunctionName("AZStorageCacheFileListGenerateSAS")]
        // ReSharper disable once UnusedMember.Global
        public static IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req)
        {

            //Get SASURI for table access
            string requestBody = new System.IO.StreamReader(req.Body).ReadToEndAsync().Result;
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            
           
            string storageAccountName = data["StorageAccountName"].ToString();
            string storageAccountKey = data["StorageAccountKey"].ToString();

            StorageCredentials storageCredentials = new StorageCredentials(storageAccountName, storageAccountKey);
            CloudStorageAccount sourceStorageAccount = new CloudStorageAccount(storageCredentials: storageCredentials, accountName: storageAccountName, endpointSuffix: "core.windows.net", useHttps: true);
            CloudTableClient client = sourceStorageAccount.CreateCloudTableClient();
            var fileListTable = client.GetTableReference("Filelist");

            SharedAccessTablePolicy policy = new SharedAccessTablePolicy()
            {
                SharedAccessExpiryTime = DateTime.UtcNow.AddYears(1),
                Permissions = SharedAccessTablePermissions.Add | SharedAccessTablePermissions.Update
            };

            var sasToken = fileListTable.GetSharedAccessSignature(policy);
            var sasCredentials = new StorageCredentials(sasToken);

            //Run in Debug and break on this point so that you can grab the SASURI
            return new OkObjectResult(new { });
        }
    }
}









