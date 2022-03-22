namespace WebApplication.Models
{
    public partial class AzureStorageChangeFeedCursor
    {
        public long SourceSystemId { get; set; }
        public string ChangeFeedCursor { get; set; }
    }
}
