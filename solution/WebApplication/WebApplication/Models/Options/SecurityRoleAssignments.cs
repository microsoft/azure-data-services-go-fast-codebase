using System.Collections.Generic;

namespace WebApplication.Models.Options
{
    public class SecurityRoleAssignments
    {
        public bool IsSubjectAreaScoped { get; set; }
        public string SecurityGroupId { get; set; }
        public List<string> UserOverideList { get; set; } = new List<string>();
        public List<string> AllowActions { get; set; } = new List<string>();
    }
}
