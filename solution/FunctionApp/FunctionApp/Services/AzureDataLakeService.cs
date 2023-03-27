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
        public async Task InjectInput(string StorageAccountName, string ContainerName, string ExecutionUid, long TaskMasterId, long TaskInstanceId, string ExecutionCommand, string ExecutionParameters, string ExecutionPath, Logging.Logging logging)
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
                logging.LogInformation($"Checking containers within storage account: {dfsUri}");

                await foreach (FileSystemItem fileSystemItem in fileSystems)
                {
                    if (fileSystemItem.Name == ContainerName)
                    {
                        containerFound = true;
                        logging.LogInformation($"Container found within storage account: {ContainerName}");

                    }
                }
                // if no container found, create one
                if (!containerFound)
                {
                    logging.LogInformation($"Creating Container within storage account: {ContainerName}");
                    var container = await dataLakeServiceClient.CreateFileSystemAsync(ContainerName);
                }
                //
                // create our file system client
                DataLakeFileSystemClient fileSystemClient = dataLakeServiceClient.GetFileSystemClient(ContainerName);
                

                //create directory clients for input / outputs / in progress
                PathResourceType pathResourceType = PathResourceType.Directory;
                DataLakeDirectoryClient inputDirectoryClient = fileSystemClient.GetDirectoryClient("input");
                DataLakeDirectoryClient outputDirectoryClient = fileSystemClient.GetDirectoryClient("output");
                DataLakeDirectoryClient inProgressDirectoryClient = fileSystemClient.GetDirectoryClient("in_progress");
                logging.LogInformation($"Creating directories if they do not exist:");

                var inputDirectory = await inputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"inputDirectory: {inputDirectory}. Note: Null result = directory exists");

                var outputDirectory = await outputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"ouputDirectory: {outputDirectory}. Note: Null result = directory exists");

                var inProgressDirectory = await inProgressDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"inProgressDirectory: {outputDirectory}. Note: Null result = directory exists");

                string fileName = ExecutionUid + ".json";
                JObject jsonContent = new JObject();

                // logic for cleansing parameter input -> convert to quoted / remove characters as required - likely to change as placeholder implementation
                // THis will need proper modification to reduce injection probability
                // alternative approach -> make each possible parameter on a command a flag (checkbox) - if true, allow a string entry to match parameter then manually build the command string
                // This logic would be done in the ADFrunFramework switch statement for VM_Execution (add another switch for each target type (i.e dbt build)).

                var executionParameters = string.Concat(ExecutionParameters.Select(c => "*!',&#^@?{}()[];+=|\\/".Contains(c) ? "" : c.ToString()));
                var executionInput = ExecutionCommand + " " + executionParameters;

                //
                jsonContent["TaskMasterId"] = TaskMasterId;
                jsonContent["TaskInstanceId"] = TaskInstanceId;
                jsonContent["ExecutionUid"] = ExecutionUid;
                jsonContent["InputCreatedUTC"] = DateTime.UtcNow.ToString();
                jsonContent["InProgressCreatedUTC"] = "";
                jsonContent["ExecutionPath"] = ExecutionPath;
                jsonContent["ExecutionCommand"] = ExecutionCommand;
                jsonContent["ExecutionParameters"] = executionParameters;
                jsonContent["ExecutionInput"] = executionInput;
                jsonContent["ExecutionOutput"] = new JObject();
                jsonContent["OutputCreatedUTC"] = "";

                string json = jsonContent.ToString();
                DataLakeFileClient fileClient = await inputDirectoryClient.CreateFileAsync(fileName);
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
                        sw.Write(json);
                        sw.Flush();
                        ms.Position = 0;
                        logging.LogInformation($"Writing : {fileName} to input folder.");
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


        public async Task DetectOutput(string StorageAccountName, string ContainerName, string ExecutionUid, Logging.Logging logging)
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


                //get directory clients for output
                PathResourceType pathResourceType = PathResourceType.Directory;
                DataLakeDirectoryClient outputDirectoryClient = fileSystemClient.GetDirectoryClient("output");

                var outputDirectory = await outputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                string fileName = ExecutionUid + ".json";

                DataLakeFileClient fileClient = outputDirectoryClient.GetFileClient(fileName);

                var fileExists = await fileClient.ExistsAsync(default);
                if (fileExists)
                {
                    // do stuff here to end function
                    var fileRead = fileClient.Read(); //not async 
                    var stream = fileRead.Value.Content;
                    StreamReader sr = new StreamReader(stream);
                    var text = sr.ReadToEnd();
                    sr.Close();

                    //archive file

                    //delete file as done
                    //await fileClient.DeleteAsync(default, default);


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
