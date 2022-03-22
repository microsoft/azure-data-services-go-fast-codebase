namespace WebApplication.Models
{
    public partial class AzureStorageListing
    {
        public long SystemId { get; set; }
        public string PartitionKey { get; set; }
        public string RowKey { get; set; }
        public string FilePath { get; set; }
    }
}
