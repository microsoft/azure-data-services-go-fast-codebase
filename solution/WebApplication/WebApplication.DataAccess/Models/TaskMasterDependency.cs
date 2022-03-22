namespace WebApplication.Models
{
    public partial class TaskMasterDependency
    {
        public long AncestorTaskMasterId { get; set; }
        public long DescendantTaskMasterId { get; set; }
    }
}
