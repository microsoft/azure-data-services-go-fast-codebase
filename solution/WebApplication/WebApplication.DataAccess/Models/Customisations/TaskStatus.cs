namespace WebApplication.Models
{
    public static partial class ModelEnums
    {
        public enum TaskStatus
        {
            Succeeded,
            FailedRetry,
            FailedNoRetry,
            Untried,
            InProgress
        }
    }
}
