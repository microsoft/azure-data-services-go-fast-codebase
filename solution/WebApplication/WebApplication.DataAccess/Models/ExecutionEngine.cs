using System;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class ExecutionEngine
    {
        [Key] public long EngineId { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string EngineName { get; set; }
        public string SystemType { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Resource Group")]
        public string ResourceGroup { get; set; }
        public Guid? SubscriptionUid { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid KeyVault Url")]
        public string DefaultKeyVaultURL { get; set; }
        public string EngineJson { get; set; }
        public Guid? LogAnalyticsWorkspaceId { get; set; }

    }
}
