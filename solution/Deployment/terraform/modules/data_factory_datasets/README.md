# Purpose
The purpose of this module is to provide a way to create all of the appropriate datasets for each of the linked service types for a singular integration runtime.

This module is parameterised to allow it to be run multiple times, once for each of the integration runtimes that is confiugred.
# For Datasets we support the sources
 - Binary file
 - Delimited Text
 - Json
 - Parquet
 - SQL Table


# We also support the following generic linked service types
 - Azure SQL
 - MS SQL Server
 - File Server
 - Generic Blob
 - Generic ADLS
 - Generic PostgeSQL (** WIP)
 - Generic Azure Synapse SQL (** WIP)
 - Generic Azure Synapse Table (** WIP)


#  The full super set of datasets is
 - Azure SQL - SQL Table
 - MS SQL Server - SQL Table
 - File Server - Binary
 - File Server - Delimited Text
 - File Server - Excel Text    
 - File Server - JSON    
 - File Server - Parquet    
 - Generic Blob - Binary
 - Generic Blob - Delimited Text
 - Generic Blob - Excel Text    
 - Generic Blob - JSON    
 - Generic Blob - Parquet    
 - Generic ADLS - Binary
 - Generic ADLS - Delimited Text
 - Generic ADLS - Excel Text    
 - Generic ADLS - JSON    
 - Generic ADLS - Parquet
 - Generic PostgeSQL (** WIP) - Table
 - Generic Azure Synapse SQL (** WIP) - Table
 - Generic Azure Synapse Data Lake (** WIP) - Binary
 - Generic Azure Synapse Data Lake (** WIP) - Delimited Text
 - Generic Azure Synapse Data Lake (** WIP) - Excel Text    
 - Generic Azure Synapse Data Lake (** WIP) - JSON    
 - Generic Azure Synapse Data Lake (** WIP) - Parquet    


# Design notes & history on linked services

- Because you cant parameterise the integration runtime for a a linked service you need to create a set of linked services for each integration runtime that you want to run within the environment.
- Because you need a set of separate linked services per IR, you also need a separate  set of datasets per IR.
- For simplicity we are initially going to create a full set of IR --> Linked Services --> Data Sets
- We want to simplify the creation & maintenance of these as much as possible
- WARNING!!!!!!!!!
    - azurerm_data_factory_custom_dataset provider doesnt support setting expressions
    - with the linked_service.parameters
    - An issue has been created here https://github.com/hashicorp/terraform-provider-azurerm/issues/14586
    - For now, I am pivoting to importing the data sets as parameterised arm templates
    
