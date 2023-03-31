using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class SubjectArea 
    {
        public virtual List<TaskGroup> TaskGroups { get; set; }
        public virtual SubjectAreaForm SubjectAreaForm { get; set; }
        //public virtual List<EntityRoleMap> SubjectAreaRoleMaps { get; set; }

        public virtual MetadataExtractionVersion MetadataExtractionVersion { get; set; }

    }
}
