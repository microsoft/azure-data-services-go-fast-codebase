using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class SourceAndTargetSystems
    {
        public long SystemId { get; set; }
        [Display(Name = "Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string SystemName { get; set; }
        [Display(Name = "Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Type")]
        public string SystemType { get; set; }
        [Display(Name = "Description")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Description")]
        public string SystemDescription { get; set; }
        [Display(Name = "Server")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Server")]
        public string SystemServer { get; set; }
        [Display(Name = "Auth Type")]
        public string SystemAuthType { get; set; }
        [Display(Name = "Username")]
        public string SystemUserName { get; set; }
        [Display(Name = "Secret Name")]
        public string SystemSecretName { get; set; }
        [Display(Name = "KeyVault BaseUrl")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid KeyVault BaseUrl")]
        public string SystemKeyVaultBaseUrl { get; set; }
        [Display(Name = "Configuration Json")]
        public string SystemJson { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
        [Display(Name = "Is External")]
        public bool IsExternal { get; set; }
    }
}
