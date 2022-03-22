using System.ComponentModel.DataAnnotations;

namespace WebApplication.Controllers
{
    public class TaskGroupMetadata
    {
        [Display(Name = "Email Address")]
        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid Email Address.")]
        public string TaskGroupName { get; set; }

    }
}
