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
using Microsoft.PowerBI.Api;
using Microsoft.Identity.Client;
using System.Threading;
using Azure.Storage.Files.DataLake;
using Azure.Storage.Files.DataLake.Models;
using Azure.Identity;
using System.Text;

namespace FunctionApp.Services
{
    public class AzureDataLakeService
    {
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly IOptions<FunctionApp.Models.Options.ApplicationOptions> _options;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly KeyVaultService _keyVaultService;

        public AzureDataLakeService(IAzureAuthenticationProvider authProvider, IOptions<FunctionApp.Models.Options.ApplicationOptions> options, TaskMetaDataDatabase taskMetaDataDatabase, KeyVaultService keyVaultService)
        {
            _authProvider = authProvider;
            _options = options;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _keyVaultService = keyVaultService;
        }
        public async Task InjectInput(string StorageAccountName, string ContainerName, Logging.Logging logging)
        {
            try
            {
                // create dfs uri for storage account
                // create auth for storage account

                string dfsUri = "https://" + StorageAccountName + ".dfs.core.windows.net";
                var cred = _authProvider.GetAzureRestApiTokenCredential("https://management.azure.com/");

                DataLakeServiceClient dataLakeServiceClient = new DataLakeServiceClient(new Uri(dfsUri),
                                        cred);
                //get storage account containers
                FileSystemTraits traits = FileSystemTraits.None;
                FileSystemStates states = FileSystemStates.None;
                var fileSystems = dataLakeServiceClient.GetFileSystemsAsync(traits, states, ContainerName, default);
                var containerFound = false;
                //check storage account for our container
                await foreach (FileSystemItem fileSystemItem in fileSystems)
                {
                    if (fileSystemItem.Name == ContainerName)
                    {
                        containerFound = true;
                    }
                }
                // if no container found, create one
                if (!containerFound)
                {
                    var container = await dataLakeServiceClient.CreateFileSystemAsync(ContainerName);
                }
                //
                // create our file system client
                DataLakeFileSystemClient fileSystemClient = dataLakeServiceClient.GetFileSystemClient(ContainerName);
                

                //create directory clients for input / outputs
                PathResourceType pathResourceType = PathResourceType.Directory;
                DataLakeDirectoryClient inputDirectoryClient = fileSystemClient.GetDirectoryClient("inputs");
                DataLakeDirectoryClient outputDirectoryClient = fileSystemClient.GetDirectoryClient("outputs");

                var inputDirectory = await inputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                var outputDirectory = await outputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);

                DataLakeFileClient fileClient = await inputDirectoryClient.CreateFileAsync("testinput.txt");
                /* Using file stream / create -> likely delete this later
                string path = @".\input.txt";
                using (FileStream fs = File.Create(path))
                {
                    byte[] info = new UTF8Encoding(true).GetBytes("testing-UID goes here");
                    fs.Write(info, 0, info.Length);
                    fs.Close();
                }
                using (FileStream fs = File.OpenRead(path))
                {
                    long fileSize = fs.Length;

                    await fileClient.AppendAsync(fs, offset: 0);

                    await fileClient.FlushAsync(position: fileSize);
                }
                File.Delete(path);
                */
                // using memory stream
                using (MemoryStream ms = new MemoryStream())
                {
                    using (StreamWriter sw = new StreamWriter(ms))
                    {
                        sw.Write("ayo22");
                        sw.Flush();
                        ms.Position = 0;
                        await fileClient.UploadAsync(ms, true, default);
                    }

                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in finding the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }


        public async Task DetectOutput(string StorageAccountName, string ContainerName, string FileName, Logging.Logging logging)
        {
            try
            {
                // create dfs uri for storage account
                // create auth for storage account

                string dfsUri = "https://" + StorageAccountName + ".dfs.core.windows.net";
                var cred = _authProvider.GetAzureRestApiTokenCredential("https://management.azure.com/");

                DataLakeServiceClient dataLakeServiceClient = new DataLakeServiceClient(new Uri(dfsUri),
                                        cred);

                // create our file system client
                DataLakeFileSystemClient fileSystemClient = dataLakeServiceClient.GetFileSystemClient(ContainerName);


                //create directory clients for input / outputs
                PathResourceType pathResourceType = PathResourceType.Directory;
                DataLakeDirectoryClient outputDirectoryClient = fileSystemClient.GetDirectoryClient("outputs");

                var outputDirectory = await outputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);

                DataLakeFileClient fileClient = outputDirectoryClient.GetFileClient(FileName);

                var fileExists = await fileClient.ExistsAsync(default);
                if (fileExists)
                {
                    // do stuff here to end function
                    var fileRead = fileClient.Read(); //not async 
                    var stream = fileRead.Value.Content;
                    StreamReader sr = new StreamReader(stream);
                    var text = sr.ReadToEnd();
                    sr.Close();
                    //delete file as done
                    await fileClient.DeleteAsync(default, default);

                    // do logic for Completion / error on execution
                }
                else
                {
                    // do nothing? maybe?
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in finding the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }

    }

}
