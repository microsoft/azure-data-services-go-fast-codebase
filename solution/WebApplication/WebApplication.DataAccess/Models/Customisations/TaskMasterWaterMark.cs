namespace WebApplication.Models
{

    public partial class TaskMasterWaterMark 
    {

        public virtual TaskMaster TaskMaster { get; set; }
        
        public string Description { get => $"{TaskMaster?.TaskMasterName}.{TaskMasterWaterMarkColumn} - {TaskMasterWaterMarkColumnType}"; }
    }
}
