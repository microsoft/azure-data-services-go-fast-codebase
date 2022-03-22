## SourceAndTargetSystems
The SourceAndTargetSystems table describes Source and Target systems such as, SQL Server, Blob Storage and Azure Data Lake Storage. Columns are used for the main attributes, but due to the variability of the specific attributes, these are stored within the SystemJSON column.

For example:
``` js
    { "Database" : "AdsGoFastStaging" }
```
or 
``` js
    { "Container" : "data" }
```
or, if SystemAuthType = "Username/Password", the Key Vault secret names should be supplied within the JSON:
``` js
	{ "Database" : "AdsGoFastStaging",
	  "UsernameKeyVaultSecretName": "usernamekey"
	  "PasswordKeyVaultSecretName": "passwordkey"
    }
```

The SystemType value must be one of:
* Azure SQL
* Azure Blob
* ADLS
* File
* MsSqlServer