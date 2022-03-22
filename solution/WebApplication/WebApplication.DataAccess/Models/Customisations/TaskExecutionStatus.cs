namespace WebApplication.Models
{
    public enum TaskExecutionStatus
    {
        FailedNoRetry,
        FailedRetry,
        Complete,
        InProgress,
        Untried
    }  
    
}