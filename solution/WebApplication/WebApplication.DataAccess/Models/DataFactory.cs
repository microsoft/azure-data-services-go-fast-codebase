using System;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class DataFactory
    {
        public long Id { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string Name { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Resource Group")]
        public string ResourceGroup { get; set; }
        public Guid? SubscriptionUid { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid KeyVault Url")]
        public string DefaultKeyVaultUrl { get; set; }
        public Guid? LogAnalyticsWorkspaceId { get; set; }
    }
}
