/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using Newtonsoft.Json;

namespace FunctionApp.Models.GetTaskInstanceJSON
{
    public class TypeIsSql
    {
        [JsonProperty(Required = Required.Always)]
        public string Database { get; set; }

        [JsonProperty(Required = Required.Default)]
        public string UsernameKeyVaultSecretName { get; set; }

        [JsonProperty(Required = Required.Default)]
        public string PasswordKeyVaultSecretName { get; set; }

    }

    public class TypeIsStorage
    {
        [JsonProperty(Required = Required.Always)]
        public string Container { get; set; }

        [JsonProperty(Required = Required.Default)]
        public string UsernameKeyVaultSecretName { get; set; }

        [JsonProperty(Required = Required.Default)]
        public string PasswordKeyVaultSecretName { get; set; }

        [JsonProperty(Required = Required.Default)]
        public string SasUriKeyVaultSecretName { get; set; }

        //[JsonProperty(Required = Required.Default)]
        //public string RelativePath { get; set; }

        //[JsonProperty(Required = Required.Default)]
        //public string DataFileName { get; set; }
    }

    public class TypeIsSendGrid
    {
        [JsonProperty(Required = Required.Always)]
        public string SenderEmail { get; set; }
        [JsonProperty(Required = Required.Always)]
        public string SenderDescription { get; set; }
    }

}

