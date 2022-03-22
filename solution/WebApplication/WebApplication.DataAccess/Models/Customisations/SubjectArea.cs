using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class SubjectArea 
    {
        public virtual List<TaskGroup> TaskGroups { get; set; }
        public virtual SubjectAreaForm SubjectAreaForm { get; set; }
        public virtual List<SubjectAreaRoleMap> SubjectAreaRoleMaps { get; set; }
    }
}
