# Azure Data Factory
This folder contains the source code used to build out all of the Azure Data Factory artefacts deployed by the accelerator. 

## Naming conventions

### Linked Services
Linked Service names match the convention `{Prefix}_{SystemType}_{IntegrationRuntime}`. The Prefix should either by `GLS` or `SLS`. `GLS` is short for `Generic Linked Service` and should be used when the Linked Service is parameterised and thus can be used to connect to multiple, underlying systems. `SLS` is short for `Static Linked Service` and is to be used when the Linked Service connects only to one specific underlying system. The `{SystemType}` segment of the name refers to the type of system that the linked service is used to connect to. The `{IntegrationRuntime}` segment of the name refers to short-name of the integration runtime that the linked service will connect via. 

**Examples** 
> Name | Description
> |---|---|
> `GLS_AzureBlobFS_Azure` | `Generic Linked Service` targeting `Azure Data Lake Gen2` via the integration runtime with the shortname of `Azure`

:file_folder: *Note linked services are not organised into folders.

### Data Sets
Data set object names match the convention `{Prefix}_{SystemType}_{SystemFormat}_{IntegrationRuntime}`. The Prefix should either by `GDS` or `SDS`. `GDS` is short for `Generic Dataset` and should be used when the dataset is parameterised and thus can be used to connect to multiple, underlying systems. `SDS` is short for `Static Dataset` and is to be used when the dataset connects only to one specific underlying system. The `{SystemType}` segment of the name refers to the type of system that the dataset is used to connect to. The `{IntegrationRuntime}` segment of the name refers to short-name of the integration runtime that the dataset will connect via. 

**Examples** 
> Name | Description
> |---|---|
> `GDS_AzureBlobFS_Binary_Azure` | `Generic Dataset` targeting `Azure Data Lake Gen2` using a `binary` format connecting via the integration runtime with the shortname of `Azure`

:file_folder: *Note datasets should be organised into folders with a separate folder for each integration runtime.  


### Pipelines
Pipeline object names match the convention `{Prefix}_{SourceSystemType}_{SourceFormat}_{TargetSystemType}_{TargetFormat}_{IntegrationRuntime}`. The Prefix should either by `GPL` or `SPL`. `GPL` is short for `Generic Pipeline` and should be used when the pipeline is parameterised and thus can be used to connect to multiple, underlying systems. `SPL` is short for `Static Pipeline` and is to be used when the pipeline connects only to one specific underlying system. The `{SourceSystemType}` and `{TargetSystemType}` segments of the name refer to the system types of the source and targets respectively.  The `{SourceFormat}` and `{TargetFormat}` segments of the name refer to the formats of the source and target respectively. The `{IntegrationRuntime}` segment of the name refers to short-name of the integration runtime on which activities will be executed. 

**Examples** 
> Name | Description
> |---|---|
> `GPL_AzureBlobFS_Binary_AzureBlobFS_Binary_Azure` | `Generic Dataset` reading data from `Azure Data Lake Gen2` using a `binary` format and writing data to `Azure Data Lake Gen2` using a `binary` format. The copy activity will occur on the integration runtime with the shortname of `Azure`

:file_folder: *Note pipelines should be organised into folders with a separate folder for each integration runtime. Under the primary folder that denotes the integration runtime there are subfolders representing `Task Types`.   
