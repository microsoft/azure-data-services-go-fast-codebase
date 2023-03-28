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
using System.Security.Cryptography;

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
        public async Task InjectInput(string StorageAccountName, string ContainerName, string ExecutionUid, long TaskMasterId, long TaskInstanceId, string ExecutionCommand, string ExecutionParameters, string ExecutionPath, string keyVaultUrl, Logging.Logging logging)
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
                DataLakeDirectoryClient archiveDirectoryClient = fileSystemClient.GetDirectoryClient("archive");

                logging.LogInformation($"Creating directories if they do not exist:");

                var inputDirectory = await inputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"inputDirectory: {inputDirectory}. Note: Null result = directory exists");

                var outputDirectory = await outputDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"ouputDirectory: {outputDirectory}. Note: Null result = directory exists");

                var inProgressDirectory = await inProgressDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"inProgressDirectory: {inProgressDirectory}. Note: Null result = directory exists");

                var archiveDirectory = await archiveDirectoryClient.CreateIfNotExistsAsync(pathResourceType, default, default);
                logging.LogInformation($"archiveDirrctory: {archiveDirectory}. Note: Null result = directory exists");

                string fileName = ExecutionUid + ".txt";
                JObject jsonContent = new JObject();

                // logic for cleansing parameter input -> convert to quoted / remove characters as required - likely to change as placeholder implementation
                // THis will need proper modification to reduce injection probability
                // alternative approach -> make each possible parameter on a command a flag (checkbox) - if true, allow a string entry to match parameter then manually build the command string
                // This logic would be done in the ADFrunFramework switch statement for VM_Execution (add another switch for each target type (i.e dbt build)).

                var executionParameters = string.Concat(ExecutionParameters.Select(c => "*!',&#^@?{}()[];+=|\\/".Contains(c) ? "" : c.ToString()));
                var executionInput = ExecutionCommand + " " + executionParameters;

                //create object
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
                //convert json to plaintext for encryption
                var plainText = jsonContent.ToString(Formatting.None);

                //aes encryption (cbc / PKCS7)
                Aes aesAlgorithm = Aes.Create();
                string keySecretName = "vmexecutorkey";
                string saltSecretName = "vmexecutorsalt";
                var secretExists = await _keyVaultService.CheckSecretExists(keySecretName, keyVaultUrl, logging);
                string vectorBase64;
                string keyBase64;
                if (secretExists)
                {
                    keyBase64 = await _keyVaultService.RetrieveSecret(keySecretName, keyVaultUrl, logging);
                    vectorBase64 = await _keyVaultService.RetrieveSecret(saltSecretName, keyVaultUrl, logging);
                    aesAlgorithm.Key = Convert.FromBase64String(keyBase64);
                    aesAlgorithm.IV = Convert.FromBase64String(vectorBase64);
                }
                else
                {
                    keyBase64 = Convert.ToBase64String(aesAlgorithm.Key);
                    vectorBase64 = Convert.ToBase64String(aesAlgorithm.IV);
                    var keyCreate = await _keyVaultService.CreateSecret(keySecretName, keyBase64, keyVaultUrl, logging);
                    var ivCreate = await _keyVaultService.CreateSecret(saltSecretName, vectorBase64, keyVaultUrl, logging);
                }

                // Create encryptor object
                ICryptoTransform encryptor = aesAlgorithm.CreateEncryptor();

                byte[] encryptedData;

                //Encryption will be done in a memory stream through a CryptoStream object
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter sw = new StreamWriter(cs))
                        {
                            sw.Write(plainText);
                        }
                        encryptedData = ms.ToArray();
                    }
                }

                var finalString = Convert.ToBase64String(encryptedData);
                //string json = jsonContent.ToString();
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
                        sw.Write(finalString);
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

        public async Task<bool> FileExists(string StorageAccountName, string ContainerName, string Directory, string FileName, Logging.Logging logging)
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


                //get directory client
                var filePath = Directory + FileName;
                DataLakeFileClient fileClient = fileSystemClient.GetFileClient(filePath);

                var fileExists = await fileClient.ExistsAsync(default);
                logging.LogInformation($"Storage Account: {StorageAccountName}");
                logging.LogInformation($"Container: {ContainerName}");
                logging.LogInformation($"Directory: {Directory}");
                logging.LogInformation($"{FileName} status: {fileExists}");

                if (fileExists)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in finding the file: {FileName} within the directory: {Directory} within the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }

        public async Task<JObject> GetJsonFile(string StorageAccountName, string ContainerName, string Directory, string FileName, Logging.Logging logging)
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


                //get directory client
                var filePath = Directory + FileName;
                DataLakeFileClient fileClient = fileSystemClient.GetFileClient(filePath);

                logging.LogInformation($"Storage Account: {StorageAccountName}");
                logging.LogInformation($"Container: {ContainerName}");
                logging.LogInformation($"Directory: {Directory}");
                logging.LogInformation($"File Name: {FileName}");
                logging.LogInformation($"Reading");
                var fileRead = await fileClient.ReadAsync(); //not async
                var stream = fileRead.Value.Content;
                StreamReader sr = new StreamReader(stream);
                var text = sr.ReadToEnd();
                sr.Close();
                logging.LogInformation($"read");
                JObject json = JObject.Parse(text);
                return json;
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in opening the file: {FileName} within the directory: {Directory} within the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }
        public async Task DeleteFile(string StorageAccountName, string ContainerName, string Directory, string FileName, Logging.Logging logging)
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


                //get directory client
                var filePath = Directory + FileName;
                DataLakeFileClient fileClient = fileSystemClient.GetFileClient(filePath);
                logging.LogInformation($"Storage Account: {StorageAccountName}");
                logging.LogInformation($"Container: {ContainerName}");
                logging.LogInformation($"Directory: {Directory}");
                logging.LogInformation($"File Name: {FileName}");
                logging.LogInformation($"Deleting");
                var fileRead = await fileClient.DeleteAsync(); 
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in deleting the file: {FileName} within the directory: {Directory} within the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }

        public async Task UploadFile(string StorageAccountName, string ContainerName, string Directory, string FileName, JObject content, Logging.Logging logging)
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


                //get directory client
                var filePath = Directory + FileName;
                DataLakeFileClient fileClient = fileSystemClient.GetFileClient(filePath);
                string fileContent = content.ToString();
                using (MemoryStream ms = new MemoryStream())
                {
                    using (StreamWriter sw = new StreamWriter(ms))
                    {
                        sw.Write(fileContent);
                        sw.Flush();
                        ms.Position = 0;
                        logging.LogInformation($"Storage Account: {StorageAccountName}");
                        logging.LogInformation($"Container: {ContainerName}");
                        logging.LogInformation($"Writing : {filePath}");
                        await fileClient.UploadAsync(ms, true, default);
                    }

                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                logging.LogErrors(new Exception($"Failure in writing the file: {FileName} within the directory: {Directory} within the container: {ContainerName} within the storage account: {StorageAccountName}"));
                throw;

            }
        }
        /*
        public async Task UploadFile(string StorageAccountName, string ContainerName, string Directory, string FileName, string content, Logging.Logging logging)
        {

        }
        */
        //currently unused func
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
