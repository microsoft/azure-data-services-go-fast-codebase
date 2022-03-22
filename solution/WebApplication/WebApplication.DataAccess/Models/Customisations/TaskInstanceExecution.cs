namespace WebApplication.Models
{
    public partial class TaskInstanceExecution
    {
        public virtual TaskInstance TaskInstance { get; set; }

        public virtual Execution Execution { get; set; }

        public string Description { get => $"{TaskInstance?.TaskMaster?.TaskMasterName} - {Execution?.StartDateTime?.LocalDateTime.ToString()??"No-Execution-Details"}"; }

        //public virtual List<AdfpipelineStats1> AdfPipelineStats { get; set; }

    }
}
