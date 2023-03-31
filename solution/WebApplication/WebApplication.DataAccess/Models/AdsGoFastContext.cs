using Microsoft.EntityFrameworkCore;

namespace WebApplication.Models
{
    public partial class AdsGoFastContext : DbContext
    {
        public AdsGoFastContext()
        {
        }
        
        public AdsGoFastContext(DbContextOptions<AdsGoFastContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ActivityLevelLogs> ActivityLevelLogs { get; set; }
        public virtual DbSet<AdfactivityErrors> AdfactivityErrors { get; set; }
        public virtual DbSet<AdfactivityRun> AdfactivityRun { get; set; }
        public virtual DbSet<AdfpipelineRun> AdfpipelineRun { get; set; }
        public virtual DbSet<AdfpipelineRun1> AdfpipelineRun1 { get; set; }
        public virtual DbSet<AdfpipelineStats> AdfpipelineStats { get; set; }
        public virtual DbSet<AdfpipelineStats1> AdfpipelineStats1 { get; set; }
        public virtual DbSet<Adfprice> Adfprice { get; set; }
        public virtual DbSet<AzureStorageChangeFeed> AzureStorageChangeFeed { get; set; }
        public virtual DbSet<AzureStorageChangeFeedCursor> AzureStorageChangeFeedCursor { get; set; }
        public virtual DbSet<AzureStorageListing> AzureStorageListing { get; set; }
// public virtual DbSet<DataFactory> DataFactory { get; set; }
        public virtual DbSet<ExecutionEngine> ExecutionEngine { get; set; }
        public virtual DbSet<EntityRoleMap> EntityRoleMap { get; set; }

        public virtual DbSet<IntegrationRuntime> IntegrationRuntime { get; set; }
        public virtual DbSet<Execution> Execution { get; set; }
        public virtual DbSet<FrameworkTaskRunner> FrameworkTaskRunner { get; set; }
        public virtual DbSet<ScheduleInstance> ScheduleInstance { get; set; }
        public virtual DbSet<ScheduleMaster> ScheduleMaster { get; set; }
        public virtual DbSet<SourceAndTargetSystems> SourceAndTargetSystems { get; set; }
        public virtual DbSet<SourceAndTargetSystemsJsonSchema> SourceAndTargetSystemsJsonSchema { get; set; }
        public virtual DbSet<TaskGroup> TaskGroup { get; set; }
        public virtual DbSet<TaskGroupDependency> TaskGroupDependency { get; set; }
        public virtual DbSet<TaskInstance> TaskInstance { get; set; }
        public virtual DbSet<TaskInstanceAndScheduleInstance> TaskInstanceAndScheduleInstance { get; set; }
        public virtual DbSet<TaskInstanceExecution> TaskInstanceExecution { get; set; }
        public virtual DbSet<TaskMaster> TaskMaster { get; set; }
        public virtual DbSet<TaskMasterDependency> TaskMasterDependency { get; set; }
        public virtual DbSet<TaskMasterWaterMark> TaskMasterWaterMark { get; set; }
        public virtual DbSet<TaskType> TaskType { get; set; }
        public virtual DbSet<TaskTypeMapping> TaskTypeMapping { get; set; }

        public virtual DbSet<IntegrationRuntimeMapping> IntegrationRuntimeMapping { get; set; }

        public virtual DbSet<TaskGroupStats> TaskGroupStats { get; set; }

        public virtual DbSet<MetadataExtractionVersion> MetadataExtractionVersion { get; set; }


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {

            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ActivityLevelLogs>(entity =>
            {
                entity.HasNoKey();

                entity.HasIndex(e => e.TaskInstanceId);

                entity.HasIndex(e => e.Timestamp)
                    .HasName("IX_ActivityLevelLogs")
                    .IsClustered();

                entity.Property(e => e.ActivityType).IsUnicode(false);

                entity.Property(e => e.Comment).IsUnicode(false);

                entity.Property(e => e.LogDateTimeOffset).HasColumnType("datetime");

                entity.Property(e => e.LogDateUtc)
                    .HasColumnName("LogDateUTC")
                    .HasColumnType("datetime");

                entity.Property(e => e.LogSource).IsUnicode(false);

                entity.Property(e => e.Message)
                    .HasColumnName("message")
                    .IsUnicode(false);

                entity.Property(e => e.OperationId)
                    .HasColumnName("operation_Id")
                    .IsUnicode(false);

                entity.Property(e => e.OperationName)
                    .HasColumnName("operation_Name")
                    .IsUnicode(false);

                entity.Property(e => e.SeverityLevel).HasColumnName("severityLevel");

                entity.Property(e => e.Status).IsUnicode(false);

                entity.Property(e => e.Timestamp)
                    .HasColumnName("timestamp")
                    .HasColumnType("datetime");
            });

            modelBuilder.Entity<AdfactivityErrors>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("ADFActivityErrors");

                entity.HasIndex(e => e.TimeGenerated)
                    .HasName("IX_ADFActivityErrors")
                    .IsClustered();

                entity.Property(e => e.ActivityName).IsUnicode(false);

                entity.Property(e => e.ActivityRunId).IsUnicode(false);

                entity.Property(e => e.ActivityType).IsUnicode(false);

                entity.Property(e => e.Annotations).IsUnicode(false);

                entity.Property(e => e.Category).IsUnicode(false);

                entity.Property(e => e.EffectiveIntegrationRuntime).IsUnicode(false);

                entity.Property(e => e.End).HasColumnType("datetime");

                entity.Property(e => e.Error).IsUnicode(false);

                entity.Property(e => e.ErrorMessage).IsUnicode(false);

                entity.Property(e => e.EventMessage).IsUnicode(false);

                entity.Property(e => e.FailureType).IsUnicode(false);

                entity.Property(e => e.Input).IsUnicode(false);

                entity.Property(e => e.Level).IsUnicode(false);

                entity.Property(e => e.LinkedServiceName).IsUnicode(false);

                entity.Property(e => e.Location).IsUnicode(false);

                entity.Property(e => e.OperationName).IsUnicode(false);

                entity.Property(e => e.Output).IsUnicode(false);

                entity.Property(e => e.PipelineName).IsUnicode(false);

                entity.Property(e => e.ResourceId).IsUnicode(false);

                entity.Property(e => e.SourceSystem).IsUnicode(false);

                entity.Property(e => e.Start).HasColumnType("datetime");

                entity.Property(e => e.Status).IsUnicode(false);

                entity.Property(e => e.Tags).IsUnicode(false);

                entity.Property(e => e.TenantId).IsUnicode(false);

                entity.Property(e => e.TimeGenerated).HasColumnType("datetime");

                entity.Property(e => e.Type).IsUnicode(false);

                entity.Property(e => e.UserProperties).IsUnicode(false);
            });

            modelBuilder.Entity<AdfactivityRun>(entity =>
            {
                entity.HasKey(e => new { e.PipelineRunUid, e.EngineId });

                entity.ToTable("ADFActivityRun");

                entity.Property(e => e.DataRead).HasColumnName("dataRead");

                entity.Property(e => e.DataWritten).HasColumnName("dataWritten");

                entity.Property(e => e.RowsCopied).HasColumnName("rowsCopied");

                entity.Property(e => e.TaskExecutionStatus).IsUnicode(false);
            });

            modelBuilder.Entity<AdfpipelineRun>(entity =>
            {
                entity.HasKey(e => new { e.TaskInstanceId, e.ExecutionUid, e.EngineId, e.PipelineRunUid });

                entity.ToTable("ADFPipelineRun");

                entity.Property(e => e.PipelineRunStatus)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<AdfpipelineRun1>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("ADFPipelineRun", "Pbi");

                entity.Property(e => e.DataRead).HasColumnName("dataRead");

                entity.Property(e => e.DataWritten).HasColumnName("dataWritten");

                entity.Property(e => e.PipelineRunStatus)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.RowsCopied).HasColumnName("rowsCopied");

                entity.Property(e => e.TaskExecutionStatus).IsUnicode(false);
            });

            modelBuilder.Entity<AdfpipelineStats>(entity =>
            {
                entity.HasKey(e => new { e.TaskInstanceId, e.ExecutionUid, e.EngineId });

                entity.ToTable("ADFPipelineStats");

                entity.Property(e => e.DataRead).HasColumnName("dataRead");

                entity.Property(e => e.DataWritten).HasColumnName("dataWritten");

                entity.Property(e => e.MaxActivityDateGenerated)
                    .HasColumnType("date")
                    .HasComputedColumnSql("(CONVERT([date],[MaxActivityTimeGenerated]))");

                entity.Property(e => e.MaxPipelineDateGenerated)
                    .HasColumnType("date")
                    .HasComputedColumnSql("(CONVERT([date],[MaxPipelineTimeGenerated]))");

                entity.Property(e => e.RowsCopied).HasColumnName("rowsCopied");

                entity.Property(e => e.TaskExecutionStatus).IsUnicode(false);
            });

            modelBuilder.Entity<AdfpipelineStats1>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("ADFPipelineStats", "Pbi");

                entity.Property(e => e.DataRead).HasColumnName("dataRead");

                entity.Property(e => e.DataWritten).HasColumnName("dataWritten");

                entity.Property(e => e.PipelineRunStatus)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.RowsCopied).HasColumnName("rowsCopied");

                entity.Property(e => e.TaskExecutionStatus).IsUnicode(false);
            });

            modelBuilder.Entity<Adfprice>(entity =>
            {
                entity.ToTable("ADFPrice");

                entity.Property(e => e.AdfpriceId).HasColumnName("ADFPriceId");

                entity.Property(e => e.Currency)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.IntegrationRunTime)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Price).HasColumnType("decimal(16, 10)");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.Unit)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.UpdatedOn).HasDefaultValueSql("(getdate())");
            });

            modelBuilder.Entity<AzureStorageChangeFeed>(entity =>
            {
                entity.HasKey(e => e.Pkey1ebebb3aD7af431593c8A438fe7a36ff)
                    .HasName("PK__AzureSto__C087B80B3EE75960");

                entity.Property(e => e.Pkey1ebebb3aD7af431593c8A438fe7a36ff).HasColumnName("Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff");

                entity.Property(e => e.EventDataBlobOperationName)
                    .HasColumnName("EventData.BlobOperationName")
                    .IsUnicode(false);

                entity.Property(e => e.EventDataBlobType)
                    .HasColumnName("EventData.BlobType")
                    .IsUnicode(false);

                entity.Property(e => e.EventType).IsUnicode(false);

                entity.Property(e => e.Subject).IsUnicode(false);

                entity.Property(e => e.Topic).IsUnicode(false);
            });

            modelBuilder.Entity<AzureStorageChangeFeedCursor>(entity =>
            {
                entity.HasKey(e => e.SourceSystemId)
                    .HasName("PK__AzureSto__8F4FFBD42DF0BE42");

                entity.Property(e => e.SourceSystemId).ValueGeneratedNever();

                entity.Property(e => e.ChangeFeedCursor).IsUnicode(false);
            });

            modelBuilder.Entity<AzureStorageListing>(entity =>
            {
                entity.HasKey(e => new { e.SystemId, e.PartitionKey, e.RowKey });

                entity.Property(e => e.PartitionKey)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.RowKey)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FilePath)
                    .HasMaxLength(2000)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ExecutionEngine>(entity =>
            {
                entity.Property(e => e.DefaultKeyVaultURL)
                    .HasColumnName("DefaultKeyVaultURL")
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.EngineName)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ResourceGroup)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<IntegrationRuntime>(entity =>
            {
                entity.Property(e => e.IntegrationRuntimeName)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });


            modelBuilder.Entity<Execution>(entity =>
            {
                entity.HasKey(e => e.ExecutionUid)
                    .HasName("PK__Executio__3E0BC9321B577B54");

                entity.Property(e => e.ExecutionUid).ValueGeneratedNever();
            });

            modelBuilder.Entity<FrameworkTaskRunner>(entity =>
            {
                entity.HasKey(e => e.TaskRunnerId)
                    .HasName("PK__Framewor__A938C613160B75A7");

                entity.Property(e => e.TaskRunnerId).ValueGeneratedNever();

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.Status)
                    .HasMaxLength(25)
                    .IsUnicode(false);

                entity.Property(e => e.TaskRunnerName)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ScheduleInstance>(entity =>
            {
                entity.HasIndex(e => new { e.ScheduledDateTimeOffset, e.ActiveYn, e.ScheduleMasterId })
                    .HasName("nci_wi_ScheduleInstance_AEC2B5B6860722A20293725FC7779B6F");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.ScheduledDateUtc).HasColumnType("datetime");
            });

            modelBuilder.Entity<ScheduleMaster>(entity =>
            {
                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");
                
                entity.Property(e => e.ScheduleDesciption)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.ScheduleCronExpression)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.ExtractionVersionId).HasMaxLength(255);

            });

            modelBuilder.Entity<SourceAndTargetSystems>(entity =>
            {
                entity.HasKey(e => e.SystemId)
                    .HasName("PK__SourceAn__9394F68A96690655");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.SystemName)
                    .IsRequired()
                    .HasMaxLength(128);


                entity.Property(e => e.SystemAuthType)
                    .IsRequired()
                    .HasMaxLength(20);

                entity.Property(e => e.SystemDescription)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.SystemJson)
                    .HasColumnName("SystemJSON")
                    .HasMaxLength(4000);

                entity.Property(e => e.SystemKeyVaultBaseUrl).HasMaxLength(500);


                entity.Property(e => e.SystemSecretName).HasMaxLength(128);

                entity.Property(e => e.SystemServer)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.SystemType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.SystemUserName).HasMaxLength(128);

                entity.Property(e => e.IsExternal).HasColumnName("IsExternal");

                entity.Property(e => e.ExtractionVersionId).HasMaxLength(255);

            });

            modelBuilder.Entity<SourceAndTargetSystemsJsonSchema>(entity =>
            {
                entity.HasKey(e => e.SystemType)
                    .HasName("PK__SourceAn__967DE26CC9D5877B");

                entity.ToTable("SourceAndTargetSystems_JsonSchema");

                entity.Property(e => e.SystemType)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TaskGroup>(entity =>
            {
                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.TaskGroupJson)
                    .HasColumnName("TaskGroupJSON")
                    .HasMaxLength(4000);

                entity.Property(e => e.TaskGroupName)
                    .IsRequired()
                    .HasMaxLength(200);
                entity.Property(e => e.ExtractionVersionId).HasMaxLength(255);

            });

            modelBuilder.Entity<TaskGroupDependency>(entity =>
            {
                entity.HasKey(e => new { e.AncestorTaskGroupId, e.DescendantTaskGroupId });

                entity.Property(e => e.DependencyType)
                    .IsRequired()
                    .HasMaxLength(200)
                    .IsUnicode(false);
                entity.Property(e => e.ExtractionVersionId).HasMaxLength(255);

            });

            modelBuilder.Entity<TaskInstance>(entity =>
            {
                entity.HasIndex(e => new { e.TaskMasterId, e.LastExecutionStatus })
                    .HasName("nci_wi_TaskInstance_B5B588158C01F320F9EC80B7B88A2418");

                entity.HasIndex(e => new { e.ScheduleInstanceId, e.TaskMasterId, e.LastExecutionStatus })
                    .HasName("nci_wi_TaskInstance_67CB7E97C34F783EB26BEBAEACEC0D7E");

                entity.HasIndex(e => new { e.TaskMasterId, e.TaskRunnerId, e.LastExecutionStatus })
                    .HasName("nci_wi_TaskInstance_A8DC1B064B0B11088227C31A5B65513B");

                entity.HasIndex(e => new { e.ScheduleInstanceId, e.TaskMasterId, e.ActiveYn, e.TaskRunnerId, e.LastExecutionStatus })
                    .HasName("nci_wi_TaskInstance_0EEF2CCAE417C39EAA3C6FFC345D5787");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.Adfpipeline)
                    .IsRequired()
                    .HasColumnName("ADFPipeline")
                    .HasMaxLength(128);

                entity.Property(e => e.CreatedOn).HasDefaultValueSql("(getdate())");

                entity.Property(e => e.LastExecutionComment)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.LastExecutionStatus)
                    .HasMaxLength(25)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TaskInstanceAndScheduleInstance>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("TaskInstanceAndScheduleInstance", "Pbi");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.Adfpipeline)
                    .IsRequired()
                    .HasColumnName("ADFPipeline")
                    .HasMaxLength(128);

                entity.Property(e => e.LastExecutionComment)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.LastExecutionStatus)
                    .HasMaxLength(25)
                    .IsUnicode(false);

                entity.Property(e => e.ScheduledDateUtc).HasColumnType("datetime");
            });

            modelBuilder.Entity<TaskInstanceExecution>(entity =>
            {
                entity.HasKey(e => new { e.ExecutionUid, e.TaskInstanceId });

                entity.Property(e => e.Comment)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.PipelineName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasMaxLength(25)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TaskMaster>(entity =>
            {
                entity.HasIndex(e => new { e.SourceSystemId, e.TargetSystemId, e.TaskGroupId, e.DependencyChainTag })
                    .HasName("nci_wi_TaskMaster_D7BDAE69478BDFB67BBA9E4F9BB3DD7F");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.DegreeOfCopyParallelism).HasDefaultValueSql("((1))");

                entity.Property(e => e.DependencyChainTag)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.TaskDatafactoryIr)
                    .IsRequired()
                    .HasColumnName("TaskDatafactoryIR")
                    .HasMaxLength(20);

                entity.Property(e => e.TaskMasterJson)
                    .HasColumnName("TaskMasterJSON")
                    .HasMaxLength(4000);

                entity.Property(e => e.TaskMasterName)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.ExtractionVersionId)
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<TaskMasterDependency>(entity =>
            {
                entity.HasKey(e => new { e.AncestorTaskMasterId, e.DescendantTaskMasterId });
            });

            modelBuilder.Entity<TaskMasterWaterMark>(entity =>
            {
                entity.HasKey(e => e.TaskMasterId)
                    .HasName("PK__TaskMast__EB7286F67BE98448");

                entity.Property(e => e.TaskMasterId).ValueGeneratedNever();

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.TaskMasterWaterMarkBigInt).HasColumnName("TaskMasterWaterMark_BigInt");

                entity.Property(e => e.TaskMasterWaterMarkString).HasColumnName("TaskMasterWaterMark_String");


                entity.Property(e => e.TaskMasterWaterMarkColumn)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.TaskMasterWaterMarkColumnType)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.TaskMasterWaterMarkDateTime)
                    .HasColumnName("TaskMasterWaterMark_DateTime")
                    .HasColumnType("datetime");

                entity.Property(e => e.TaskWaterMarkJson)
                    .HasColumnName("TaskWaterMarkJSON")
                    .HasMaxLength(4000);
            });

            modelBuilder.Entity<TaskType>(entity =>
            {
                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.TaskExecutionType)
                    .IsRequired()
                    .HasMaxLength(5);

                entity.Property(e => e.TaskTypeName)
                    .IsRequired()
                    .HasMaxLength(128);
            });

            modelBuilder.Entity<TaskTypeMapping>(entity =>
            {
                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.MappingName)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.MappingType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.SourceSystemType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.SourceType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.TargetSystemType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.TargetType)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.TaskInstanceJsonSchema).IsUnicode(false);

                entity.Property(e => e.TaskMasterJsonSchema).IsUnicode(false);
            });


            modelBuilder.Entity<IntegrationRuntimeMapping>(entity =>
            {
                entity.HasKey(e => e.IntegrationRuntimeMappingId);

                entity.Property(e => e.IntegrationRuntimeId)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.IntegrationRuntimeName)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.SystemId)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

            });

            modelBuilder.Entity<MetadataExtractionVersion>(entity =>
            {
                entity.HasKey(e => e.ExtractionVersionId);

                entity.Property(e => e.ExtractionVersionId)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.ExtractedDateTime).HasColumnType("datetime2(0)");
            });

            modelBuilder.Entity<SubjectArea>(entity =>
            {
                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.DefaultTargetSchema)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.SubjectAreaName)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.UpdatedBy)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ValidFrom).HasColumnType("datetime2(0)");

                entity.Property(e => e.ValidTo).HasColumnType("datetime2(0)");
                entity.Property(e => e.ExtractionVersionId).HasMaxLength(255);

            });

            modelBuilder.Entity<SubjectAreaForm>(entity =>
            {
                entity.Property(e => e.FormJson).IsUnicode(false);

                entity.Property(e => e.UpdatedBy)
                    .HasMaxLength(255)
                    .IsUnicode(false);

               
            });

            modelBuilder.Entity<SubjectAreaSystemMap>(entity =>
            {
                entity.HasKey(e => new { e.SubjectAreaId, e.SystemId, e.MappingType })
                    .HasName("PK__SubjectA__11271F966209195F");

                entity.Property(e => e.ActiveYn).HasColumnName("ActiveYn");

                entity.Property(e => e.AllowedSchemas)
                    .IsRequired()
                    .IsUnicode(false);

                entity.Property(e => e.DefaultTargetSchema)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.UpdatedBy)
                    .HasMaxLength(255)
                    .IsUnicode(false);

            });

            modelBuilder.Entity<EntityRoleMap>(entity =>
            {
                entity.HasKey(e => new { e.EntityRoleMapId })
                    .HasName("EntityRoleMap_PK");

                entity.Property(e => e.EntityTypeName)
                    .HasMaxLength(255)
                    .IsUnicode(false); 
                entity.Property(e => e.ApplicationRoleName)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.ActiveYN).HasColumnName("ActiveYN");

                entity.Property(e => e.ExpiryDate).HasColumnType("date");

                entity.Property(e => e.UpdatedBy)
                    .HasMaxLength(255)
                    .IsUnicode(false);

            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

        public DbSet<WebApplication.Models.SubjectArea> SubjectArea { get; set; }

        public DbSet<WebApplication.Models.SubjectAreaForm> SubjectAreaForm { get; set; }

    }
}
