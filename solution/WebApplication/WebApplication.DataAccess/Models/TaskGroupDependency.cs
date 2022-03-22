using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskGroupDependency
    {
        [Display(Name = "Ancestor Task Group")]
        public long AncestorTaskGroupId { get; set; }
        [Display(Name = "Descendant Task Group")]
        public long DescendantTaskGroupId { get; set; }
        [Display(Name = "Dependency Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Dependency Type")]
        public string DependencyType { get; set; }
    }
}
