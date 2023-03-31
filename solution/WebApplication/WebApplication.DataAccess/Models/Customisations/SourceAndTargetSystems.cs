using System.Collections.Generic;

namespace WebApplication.Models
{
    public partial class SourceAndTargetSystems
    {
        public virtual List<TaskMaster> TaskMastersSource { get; set; }
        public virtual List<TaskMaster> TaskMastersTarget { get; set; }
       
        public virtual List<IntegrationRuntimeMapping> IntegrationRuntimeMappings { get; set; }

        public virtual MetadataExtractionVersion MetadataExtractionVersion { get; set; }

    }
}
