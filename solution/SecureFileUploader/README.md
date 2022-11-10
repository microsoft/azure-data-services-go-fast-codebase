# Secure File Uploader

## What is this Project?

The Secure File Uploader is a suite of tools that allows Programs to be managed from a central Web Portal. This Web Portal has a serverless component for managing the starting of Programs and performing mail outs to invitees. The mail sent to invitees contains a unique access token which, which clicked will enable them to upload a file to downstream Azure Storage - ideally with limited VNET access.

Emails are sent via SendGrid. App persistence is via SQL Server and Entity Framework. Front-ends are React SPA.

Invitee information can be uploaded using a CSV through the Portal or by an API in the ``` SecureFileUploader.Functions ``` project.

The intent behind the ``` SecureFileUploader.CommonZone.Web ``` app is that it will be hosted on a publicly accessible Azure App Service, whereas the ``` SecureFileUploader.Portal.Web ``` admin portal and ``` SecureFileUploader.Functions ``` should be VNET integrated with private storage.

# Solution Decisions

## Date times

The solution uses UTC date time values throughout. The only exception is when presenting date time values to the user, where the output format will be dictated by the required functionality.

The API expects/provides UTC date time values.

A development guard exists in the db context preventing non UTC values from being persisted. This guard is not present in other environments (e.g., staging and production).

## Cryptography

Cryptography is provided by an adapted Microsoft solution. Access tokens sent via email are encrypted and then decrypted using this methodology.

# Local Dev Setup

- SQL Server Developer Edition is sufficient
- Will require a valid SendGrid ( https://sendgrid.com/ ) API key (see: ``` SecureFileUploader.Functions\local.
settings.example.json  ``` )
- Azure Storage Emulator is required locally
- Pay attention to placeholder values in  ``` SecureFileUploader.Functions ``` settings as links are emailed to consumers (i.e. yourself locally) may need to be updated based on which port ``` SecureFileUploader.Portal.Web ``` is running.

## .NET API and React
See: ``` ./apps/SecureFileUploader.Portal.Web/README.md ```

## Regenerating API Client for React Project

1. If it is not already installed, install NPX https://www.npmjs.com/package/npx
2. Ensure the API project is running, take note of the local address/port
3. From this folder run ``` npx swagger-typescript-api -p https://localhost:7283/swagger/v1/swagger.json -o ./apps/SecureFileUploader.Portal.Web/ClientApp/src/services/api -n api-client.ts --disableStrictSSL ```
    * Noting --disableStrictSSL to bypass self-signed certificate errors
    * Noting the port may have changed, alter as needs be
    * Completed with Node 16.14.2 LTS

## Running the Solution Locally

Ensure local appsettings and local.settings.json are in place then:

- Start the Portal Web (launchSettings.json provided)
- Start CommonZone Web (launchSettings.json provided)
- Start the Azure Function

### Settings Initialisation

See: ``` SecureFileUploader.Portal.Web\Samples ``` for sample SQL scripts which must be run first as well as a sample CSV program file for upload.

## EF Core usage

- See ``` SecureFileUploader.Portal.Web\appsettings.example.json ``` for a suggested SQL Server connection string. Ensure that is set or customized as required.

From this main root folder:

### Add a Migration
``` dotnet ef migrations add "SomeMigration" --project "libs\SecureFileUploader.data\SecureFileUploader.Data.csproj" --startup-project "apps\SecureFileUploader.portal.web\SecureFileUploader.Portal.Web.csproj" ```

### Execute an Update
``` dotnet ef database update --project "libs\SecureFileUploader.data\SecureFileUploader.Data.csproj" --startup-project "apps\SecureFileUploader.portal.web\SecureFileUploader.Portal.Web.csproj" ```

# Azure Setup

## External Dependencies

- Will require a valid SendGrid ( https://sendgrid.com/ ) API key (see: ``` SecureFileUploader.Functions\local.settings.example.json  ``` )

## Authentication

This ``` SecureFileUploader.Portal.Web ``` project relies on Azure App-Service built authentication (aka "Easy Auth") for authorised access. ``` SecureFileUploader.Functions ``` functions are guarded by Function Keys.

## CORS Setup

Under the corresponding App Service for ``` SecureFileUploader.Portal.Web ``` an entry for the FQDN of the App Service will need to be entered as an allowed origin. e.g. for an App Service https://my-app-service.azurewebsites.net - enter this URL as an allowed origin.

# Azure Permissions

Ensure the deployed ``` SecureFileUploader.Functions  ``` and ``` SecureFileUploader.Portal.Web ``` apps have Managed Identity turned on and permissions assigned to their appropriate KeyVaults

The deployed ``` SecureFileUploader.Functions  ``` App Service needs Blob Store Contributor access to the transient in storage account.

## KevVault Items

The following items are required in the KeyVault with the following values:
* SENDGRID-API-KEY -> The Api key of the relevant SendGrid account
* SFU-DB-CONTEXT -> A DB Connection string including username/password for database access
* FUNCTION-API-KEY -> A Function ApiKey/Code to access a HTTP Function

### Cryptography

Inspect ``` CryptographyProvider.cs ``` and take note of the comments around using a KeyVault and storing the key and initialization vector. Adapted from https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.aes?view=net-6.0

## Database Setup

There is currently no EF Migrate task in the referenced Pipelines. The database schema was deployed thusly:
1. Generate the schema:
``` dotnet ef migrations script --idempotent --project "libs\SecureFileUploader.data\SecureFileUploader.Data.csproj" --startup-project "apps\SecureFileUploader.Portal.Web\SecureFileUploader.Portal.Web.csproj" > ./script.sql ```
2. Log in to the database as an admin and run the migration
3. Create application users as need be
4. Place the generated password for the correct user in the KeyVault


## Other notes

We have noted that during deployment for the first time, the CRON trigger fails - restart the Function App if you encounter this problem.


