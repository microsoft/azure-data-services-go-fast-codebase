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

namespace AdsGoFastDbUp
{

    public class Options
    {
        [Option('v', "verbose", Required = false, HelpText = "Set output to verbose messages.")]
        public bool Verbose { get; set; }
        [Option('c', "connectionString", Required = true, HelpText = "Target Database Connection String.")]
        public string connectionString { get; set; }
        [Option('a', "azure", Required = true, HelpText = "Should azure integrated auth be used.")]
        public bool azure { get; set; }
        [Option("ResourceGroupName", Required = false, HelpText = "Parameter for the scripts.")]
        public string ResourceGroupName { get; set; }
        [Option("KeyVaultName", Required = false, HelpText = "Parameter for the scripts.")]
        public string KeyVaultName { get; set; }
        [Option("LogAnalyticsWorkspaceId", Required = false, HelpText = "Parameter for the scripts.")]
        public string LogAnalyticsWorkspaceId { get; set; }
        [Option("SubscriptionId", Required = false, HelpText = "Parameter for the scripts.")]
        public string SubscriptionId { get; set; }
        [Option("SampleDatabaseName", Required = false, HelpText = "Parameter for the scripts.")]
        public string SampleDatabaseName { get; set; }
        [Option("StagingDatabaseName", Required = false, HelpText = "Staging Parameter for the scripts.")]
        public string StagingDatabaseName { get; set; }
        
        [Option("MetadataDatabaseName", Required = false, HelpText = "Metadata Parameter for the scripts.")]
        public string MetadataDatabaseName { get; set; }

        [Option("SIFDatabaseName", Required = true, HelpText = "SIF Parameter for scripts.")]
        public string SIFDatabaseName { get; set; }


        [Option("BlobStorageName", Required = false, HelpText = "BlobStorageName Parameter for the scripts.")]
        public string BlobStorageName { get; set; }
        [Option("AdlsStorageName", Required = false, HelpText = "AdlsStorageName Parameter for the scripts.")]
        public string AdlsStorageName { get;set; }
        [Option("DataFactoryName", Required = false, HelpText = "DataFactoryName Parameter for the scripts.")]
        public string DataFactoryName { get; set; }
        [Option("WebAppName", Required = false, HelpText = "WebAppName Parameter for the scripts.")]
        public string WebAppName { get; set; }
        [Option("FunctionAppName", Required = false, HelpText = "FunctionAppName Parameter for the scripts.")]
        public string FunctionAppName { get; set; }
        [Option("SqlServerName", Required = true, HelpText = "SqlServerName Parameter for the scripts.")]
        public string SqlServerName { get; set; }
        [Option("SynapseWorkspaceName", Required = false, HelpText = "SynapseWorkspaceName Parameter for the scripts.")]
        public string SynapseWorkspaceName { get; set; }
        [Option("SynapseDatabaseName", Required = false, HelpText = "SynapseDatabaseName Parameter for the scripts.")]
        public string SynapseDatabaseName { get; set; }
        [Option("SynapseSQLPoolName", Required = false, HelpText = "SynapseSQLPoolName Parameter for the scripts.")]
        public string SynapseSQLPoolName { get; set; }
        [Option("PurviewAccountName", Required = false, HelpText = "PurviewAccountName Parameter for the scripts.")]
        public string PurviewAccountName { get; set; }

    }

    class Program
    {
        public static string JournalTableSchema = "dbo";
        public static string JournalTableName = "dbupschemaversions";

        static int Main(string[] args)
        {
            int RetVal = -1;

#if DEBUG
            //Set args from local.settings
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

            builder.WithVariable("SIFDatabaseName", o.SIFDatabaseName);

            builder.WithVariable("MetadataDatabaseName", o.MetadataDatabaseName);
            builder.WithVariable("BlobStorageName", o.BlobStorageName);
            builder.WithVariable("AdlsStorageName", o.AdlsStorageName);
            builder.WithVariable("WebAppName", o.WebAppName);
            builder.WithVariable("FunctionAppName", o.FunctionAppName);
            builder.WithVariable("SqlServerName", o.SqlServerName);
            builder.WithVariable("SynapseWorkspaceName", o.SynapseWorkspaceName);
            builder.WithVariable("SynapseDatabaseName", o.SynapseDatabaseName);
            builder.WithVariable("SynapseSQLPoolName", o.SynapseSQLPoolName);
            builder.WithVariable("PurviewAccountName", o.PurviewAccountName);


            return builder.Build();
        }
    }
}
