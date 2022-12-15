namespace SecureFileUploader.Common.Interfaces;

public interface IStorageService
{
    Task<string> UploadToTransientIn(Stream fileContents, string fileExtension, Guid inviteeId);
}
