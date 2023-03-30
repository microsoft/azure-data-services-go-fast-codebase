using CommandLine;
using DbUp;
using DbUp.Engine;
using DbUp.Engine.Transactions;
using DbUp.Helpers;
using DbUp.SqlServer;
using Microsoft.Azure.Services.AppAuthentication;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.Json;

namespace MetadataCICD
{

    public class Options
    {
        [Option('v', "verbose", Required = false, HelpText = "Set output to verbose messages.")]
        public bool Verbose { get; set; }
        [Option('c', "connectionString", Required = true, HelpText = "Target Database Connection String.")]
        public string connectionString { get; set; }
        [Option('a', "azure", Required = true, HelpText = "Should azure integrated auth be used.")]
        public bool azure { get; set; }
        [Option("ResourceGroupName", Required = true, HelpText = "Parameter for the scripts.")]
        public string ResourceGroupName { get; set; }
        [Option("KeyVaultName", Required = true, HelpText = "Parameter for the scripts.")]
        public string KeyVaultName { get; set; }
        [Option("LogAnalyticsWorkspaceId", Required = true, HelpText = "Parameter for the scripts.")]
        public string LogAnalyticsWorkspaceId { get; set; }
        [Option("SubscriptionId", Required = true, HelpText = "Parameter for the scripts.")]
        public string SubscriptionId { get; set; }
        [Option("SampleDatabaseName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SampleDatabaseName { get; set; }
        [Option("StagingDatabaseName", Required = true, HelpText = "Parameter for the scripts.")]
        public string StagingDatabaseName { get; set; }
        [Option("MetadataDatabaseName", Required = true, HelpText = "Parameter for the scripts.")]
        public string MetadataDatabaseName { get; set; }
        [Option("BlobStorageName", Required = true, HelpText = "Parameter for the scripts.")]
        public string BlobStorageName { get; set; }
        [Option("AdlsStorageName", Required = true, HelpText = "Parameter for the scripts.")]
        public string AdlsStorageName { get;set; }
        [Option("DataFactoryName", Required = true, HelpText = "Parameter for the scripts.")]
        public string DataFactoryName { get; set; }
        [Option("WebAppName", Required = true, HelpText = "Parameter for the scripts.")]
        public string WebAppName { get; set; }
        [Option("FunctionAppName", Required = true, HelpText = "Parameter for the scripts.")]
        public string FunctionAppName { get; set; }
        [Option("SqlServerName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SqlServerName { get; set; }
        [Option("SynapseWorkspaceName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SynapseWorkspaceName { get; set; }
        [Option("SynapseDatabaseName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SynapseDatabaseName { get; set; }
        [Option("SynapseLakeDatabaseContainerName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SynapseLakeDatabaseContainerName { get; set; }
        [Option("SynapseSQLPoolName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SynapseSQLPoolName { get; set; }
        [Option("SynapseSparkPoolName", Required = true, HelpText = "Parameter for the scripts.")]
        public string SynapseSparkPoolName { get; set; }
        [Option("PurviewAccountName", Required = true, HelpText = "Parameter for the scripts.")]
        public string PurviewAccountName { get; set; }           
        [Option("DatabricksWorkspaceURL", Required = true, HelpText = "Parameter for the scripts.")]
        public string DatabricksWorkspaceURL { get; set; }
        [Option("DatabricksWorkspaceResourceID", Required = true, HelpText = "Parameter for the scripts.")]
        public string DatabricksWorkspaceResourceID { get; set; }
        [Option("DefaultInstancePoolID", Required = true, HelpText = "Parameter for the scripts.")]
        public string DefaultInstancePoolID { get; set; }
        [Option("CmdExecutorVMName", Required = true, HelpText = "Parameter for the scripts.")]
        public string CmdExecutorVMName { get; set; }
        [Option("CmdExecutorVMAdlsName", Required = true, HelpText = "Parameter for the scripts.")]
        public string CmdExecutorVMAdlsName { get; set; }
    }

    class Program
    {
        public static string JournalTableSchema = "dbo";
        public static string JournalTableName = "metadatacicdschemaversions";

        static int Main(string[] args)
        {
            int RetVal = -1;

#if DEBUG
            //Set args from local.settings
            Console.WriteLine($"Reading Local Settings");
            using FileStream openStream = File.OpenRead("local.settings.json");
            var o = JsonSerializer.DeserializeAsync<Options>(openStream).Result;
            RetVal = MethodBody(o);
#else
            Parser.Default.ParseArguments<Options>(args).WithParsed<Options>(o => { RetVal = MethodBody(o);  });
#endif
            return RetVal;

        }


        private static int MethodBody(Options o)
        {
            if (o.Verbose)
            {
                Console.WriteLine($"Verbose output enabled. Current Arguments: -v {o.Verbose}");
                Console.WriteLine("Quick Start Example! App is in Verbose mode!");
            }
            else
            {
                Console.WriteLine($"Current Arguments: -v {o.Verbose}");
                Console.WriteLine("Quick Start Example!");
            }
            var engine = GetEngine(o, null, true);
            List<SqlScript> AllScripts = engine.GetDiscoveredScripts();


            List<string> Releases = new List<string>();
            foreach (var script in AllScripts)
            {
                string[] parts = script.Name.Split('.');
                if (!(Releases.Contains(parts[1])))
                {
                    Releases.Add(parts[1]);
                }
            }


            foreach (string r in Releases.OrderBy(r => r))
            {
                var A = GetEngine(o, r + "." + "A_Journaled", true);

                var result_A = A.PerformUpgrade();
                if (!result_A.Successful)
                {
                    return ReturnError(result_A.Error.ToString());
                }

            }

            ShowSuccess();

            return 0;
        }


        private static void ShowSuccess()
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("Success!");
            Console.ResetColor();
        }

        private static int ReturnError(string error)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine(error);
            Console.ResetColor();
            return -1;
        }


        private static DbUp.Engine.UpgradeEngine GetEngine(Options o, string filterstring, bool JournalYN)
        {
            DbUp.Builder.UpgradeEngineBuilder builder = null;
            if (!o.azure)
            {
                builder = DeployChanges.To.SqlDatabase(o.connectionString, "dbo", false);
            }
            else
            {
                builder = DeployChanges.To.AzureSqlDatabaseWithIntegratedSecurity(o.connectionString, "dbo");
            }

            builder.WithTransactionPerScript()
                            .LogToConsole()
                            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), s => filterstring == null || s.Contains(filterstring));

            if (JournalYN)
            {
                builder.JournalToSqlTable(JournalTableSchema, JournalTableName);
            }
            else
            {
                builder.JournalTo(new NullJournal());
            }
            builder.WithVariable("DataFactoryName", o.DataFactoryName);
            builder.WithVariable("ResourceGroupName", o.ResourceGroupName);
            builder.WithVariable("KeyVaultName", o.KeyVaultName);
            builder.WithVariable("LogAnalyticsWorkspaceId", o.LogAnalyticsWorkspaceId);
            builder.WithVariable("SubscriptionId", o.SubscriptionId);
            builder.WithVariable("SampleDatabaseName", o.SampleDatabaseName);
            builder.WithVariable("StagingDatabaseName", o.StagingDatabaseName);
            builder.WithVariable("MetadataDatabaseName", o.MetadataDatabaseName);
            builder.WithVariable("BlobStorageName", o.BlobStorageName);
            builder.WithVariable("AdlsStorageName", o.AdlsStorageName);
            builder.WithVariable("WebAppName", o.WebAppName);
            builder.WithVariable("FunctionAppName", o.FunctionAppName);
            builder.WithVariable("SqlServerName", o.SqlServerName);
            builder.WithVariable("SynapseWorkspaceName", o.SynapseWorkspaceName);
            builder.WithVariable("SynapseDatabaseName", o.SynapseDatabaseName);
            builder.WithVariable("SynapseSQLPoolName", o.SynapseSQLPoolName);
            builder.WithVariable("SynapseSparkPoolName", o.SynapseSparkPoolName);            
            builder.WithVariable("PurviewAccountName", o.PurviewAccountName);
            builder.WithVariable("SynapseLakeDatabaseContainerName", o.SynapseLakeDatabaseContainerName);
            builder.WithVariable("DatabricksWorkspaceURL", o.DatabricksWorkspaceURL);
            builder.WithVariable("DatabricksWorkspaceResourceID", o.DatabricksWorkspaceResourceID);
            builder.WithVariable("DefaultInstancePoolID", o.DefaultInstancePoolID);
            builder.WithVariable("CmdExecutorVMName", o.CmdExecutorVMName);
            builder.WithVariable("CmdExecutorVMAdlsName", o.CmdExecutorVMAdlsName);

            return builder.Build();
        }
    }
}
