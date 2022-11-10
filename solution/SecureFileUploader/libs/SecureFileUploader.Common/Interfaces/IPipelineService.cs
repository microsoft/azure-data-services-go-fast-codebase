namespace SecureFileUploader.Common.Interfaces
{
    public interface IPipelineService
    {
        Task<string> TriggerTransInToBronzePipeline(string sourceFile);
    }
}
