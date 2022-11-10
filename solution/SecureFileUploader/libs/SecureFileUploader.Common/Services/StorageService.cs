using Azure.Identity;
using Azure.Storage.Blobs;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NodaTime;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Settings;
using SecureFileUploader.Data;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;

namespace SecureFileUploader.Common.Services;

public class StorageService : IStorageService
{
    private readonly StorageSettings _storageSettings;
    private readonly ILogger<StorageService> _logger;
    private readonly IInviteeService _inviteeService;
    private readonly IInviteeEventTypeService _inviteeEventTypeService;
    private readonly IClock _dateTimeProvider;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;

    private const string DevBlobStoreConnectionString = "UseDevelopmentStorage=true";

    public StorageService(IOptions<StorageSettings> storageSettingsAccessor,
        ILogger<StorageService> logger, IInviteeService inviteeService,
        IInviteeEventTypeService inviteeEventTypeService,
        IClock dateTimeProvider, SecureFileUploaderContext secureFileUploaderContext)
    {
        _storageSettings = storageSettingsAccessor.Value;
        _logger = logger;
        _inviteeService = inviteeService;
        _inviteeEventTypeService = inviteeEventTypeService;
        _dateTimeProvider = dateTimeProvider;
        _secureFileUploaderContext = secureFileUploaderContext;
    }

    /// <summary>
    /// Uploads a file stream to the transient-in. Uses the specific Invitee to divine where
    /// to specific upload.
    /// </summary>
    /// <param name="fileContents">Contents to be uploaded to the Transient-in</param>
    /// <param name="inviteeId">The Invitee related to the upload. Used to determine output location.</param>
    public async Task<string> UploadToTransientIn(Stream fileContents, string fileExtension, Guid inviteeId)
    {
        var blobContainerClient = CreateBlobContainerClient(_storageSettings.ContainerName);

        // Construct an output path based on Invitee
        var outputFileName = await DetermineOutputFilename(fileExtension, inviteeId);
        var outputFolder = await DetermineOutputFolder(inviteeId);

        var outputPath = $"{outputFolder}{outputFileName}";

        var blobClient = blobContainerClient.GetBlobClient(outputPath);
        // By design, overwrite
        await blobClient.UploadAsync(fileContents, overwrite: true);

        // Add InviteeEvent for the successful upload
        await AddInviteeStorageEvent(inviteeId, outputPath);
        _logger.LogInformation("Uploaded file to container: {container} at location: {location}",
            _storageSettings.ContainerName, outputPath);

        return outputFolder;
    }

    private BlobContainerClient CreateBlobContainerClient(string containerName)
    {
        var baseUri = _storageSettings.TransientInBlobStoreUri;
        if (baseUri.Contains(DevBlobStoreConnectionString))
        {
            // Locally this is far more simple than playing around with Azurite certs and
            // local URLs
            return new BlobContainerClient(baseUri, containerName);
        }

        var path = baseUri.EndsWith(Path.AltDirectorySeparatorChar) ? $"{baseUri}{containerName}" :
            // Guard against dodgy config
            $"{baseUri}/{containerName}";

        // This DefaultAzureCredential will connect locally to a remote blob store you have created yourself without an issue
        // The intent for a "pre-prod" instance would be to use a managed identity for an Azure Function/App Service
        // authed against a blob store. Again this constructor should handle it.
        // This setup will also handle a cross-subscription/tenancy authorisation against a specific
        // Azure App Registration with the following env/settings:
        // AZURE_CLIENT_ID, AZURE_CLIENT_SECRET and AZURE_TENANT_ID

        return new BlobContainerClient(new Uri(path), new DefaultAzureCredential());
    }

    /// <summary>
    /// Add a File Upload storage event at a particular path.
    /// </summary>
    /// <param name="inviteeId">The Invitee who generated the event.</param>
    /// <param name="filePath">The destination path.</param>
    private async Task AddInviteeStorageEvent(Guid inviteeId, string filePath)
    {
        var eventType = await _inviteeEventTypeService.GetOrAddAsync("File Upload");
        var inviteeEvent = new InviteeEventDataModel {
            InviteeId = inviteeId,
            EventTypeId = eventType.Id,
            Description = $"File uploaded to Transient in: {filePath}",
            PerformedBy = "System",
            PerformedOn = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc()
        };
        await _secureFileUploaderContext.InviteeEvent.AddAsync(inviteeEvent);
        await _secureFileUploaderContext.SaveChangesAsync();
    }

    /// <summary>
    /// Parse the reporting quarter and container name from an Invitee
    /// </summary>
    /// <param name="inviteeId">An invitee to load</param>
    /// <returns>A transient-in output folder name</returns>
    private async Task<string> DetermineOutputFolder(Guid inviteeId)
    {
        var year = DateTime.UtcNow.ToString("yyyy");
        var invitee = await _inviteeService.GetByIdAsync(inviteeId);
        if (invitee == null)
        {
            throw new ArgumentException($"Cannot find inviteeId: {inviteeId}");
        }
        // overkill to use the path separator here imho
        return
            $"/reporting_quarter_{year}_{invitee.ReportingQuarter}/{invitee.PHN}/{invitee.ContainerName}/";
    }

    /// <summary>
    /// Parse the output filename for a given invitee from the CRM ID and Container Name
    /// </summary>
    /// <param name="fileExtension"></param>
    /// <param name="inviteeId">An invitee to load</param>
    /// <returns>A transient-in output filename</returns>
    private async Task<string> DetermineOutputFilename(string fileExtension, Guid inviteeId)
    {
        var invitee = await _inviteeService.GetByIdAsync(inviteeId);
        if (invitee == null)
        {
            throw new ArgumentException($"Cannot find inviteeId: {inviteeId}");
        }

        if (string.IsNullOrWhiteSpace(fileExtension))
        {
            fileExtension = ".json";
        }

        return $"{invitee.CrmId}-{invitee.ContainerName}.{fileExtension}";
    }
}
