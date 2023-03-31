using System;
using System.Collections.Generic;
using System.Text;

namespace WebApplication.Models
{
    public partial class MetadataExtractionVersion
    {        
         public virtual List<TaskMaster> TaskMasters { get; set; }
        public virtual List<SourceAndTargetSystems> SourceAndTargetSystems { get; set; }
        public virtual List<TaskGroup> TaskGroups { get; set; }
        public virtual List<TaskGroupDependency> TaskGroupDependencies { get; set; }
        public virtual List<SubjectArea> SubjectAreas { get; set; }
        public virtual List<ScheduleMaster> ScheduleMasters { get; set; }


    }
}
