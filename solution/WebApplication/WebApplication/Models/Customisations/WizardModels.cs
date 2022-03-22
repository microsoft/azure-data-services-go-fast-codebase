using System;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models.Wizards
{
    public partial class ExternalFileUpload
    {
        public Int64 UploadSystemId { get; set; }
        public Int64 EmailSystemId { get; set; }
        public Int64 TargetSystemId { get; set; }
        public Int64 ScheduleMasterId { get; set; }

        public Int64 TaskGroupId { get; set; }

        public string ExternalParties { get; set; }
        public string UploadFileName { get; set; }


        [Display(Name = "Email Address")]
        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid Email Address.")]
        public string Email { get; set; }
        [Display(Name = "Email Address")]
        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid Email Address.")]
        public string OperatorEmail { get; set; }
    }
}
