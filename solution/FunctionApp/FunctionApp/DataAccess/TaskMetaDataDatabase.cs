/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using FunctionApp.Authentication;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using Microsoft.Extensions.Options;

namespace FunctionApp.DataAccess
{
    //Todo Update to IDisposable
    public class TaskMetaDataDatabase
    {
        private readonly IAzureAuthenticationProvider _azureAuthProvider;
        private readonly ApplicationOptions _options;

        public TaskMetaDataDatabase(IOptions<ApplicationOptions> options, IAzureAuthenticationProvider azureAuthProvider)
        {
            _azureAuthProvider = azureAuthProvider;
            _options = options.Value;
        }

        public void LogTaskInstanceCompletion(System.Int64 TaskInstanceId, System.Guid ExecutionId, TaskInstance.TaskStatus Status, System.Guid AdfRunUid, string Comment)
        {
            using var con = GetSqlConnection();
            Dictionary<string, object> sqlParams = new Dictionary<string, object>
                    {
                        { "ExecutionStatus", Status.ToString() },
                        { "TaskInstanceId", TaskInstanceId},
                        { "ExecutionUid", ExecutionId},
                        { "AdfRunUid", AdfRunUid},
                        { "Comment", Comment}
                    };

            string cmd = @"exec UpdTaskInstanceExecution @ExecutionStatus, @TaskInstanceId, @ExecutionUid, @AdfRunUid, @Comment";

            con.Execute(cmd, sqlParams);
            
        }

        public string GetConnectionString()
        {
            SqlConnectionStringBuilder scsb = new SqlConnectionStringBuilder
            {
                DataSource = _options.ServiceConnections.AdsGoFastTaskMetaDataDatabaseServer,
                InitialCatalog = _options.ServiceConnections.AdsGoFastTaskMetaDataDatabaseName
            };
            if (_options.ServiceConnections.AdsGoFastTaskMetaDataDatabaseUseTrustedConnection)
            {
                scsb.IntegratedSecurity = true;
            }
            else
            {
                scsb.IntegratedSecurity = false;
            }
            return scsb.ConnectionString;

        }

        public void ExecuteSql(string SqlCommandText)
        {
            using var cmd = new SqlCommand
            {
                Connection = GetSqlConnection(),
                CommandText = SqlCommandText
            };
            cmd.ExecuteNonQueryWithVerboseThrow();
        }


        public static void ExecuteSql(string SqlCommandText, SqlConnection con)
        {
            using var cmd = new SqlCommand
            {
                Connection = con,
                CommandText = string.Format(SqlCommandText)
            };
            cmd.ExecuteNonQueryWithVerboseThrow();
        }

        public SqlConnection GetSqlConnection()
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            if (!_options.ServiceConnections.AdsGoFastTaskMetaDataDatabaseUseTrustedConnection)
            {
                string token = _azureAuthProvider.GetAzureRestApiToken("https://database.windows.net/").Result;
                con.AccessToken = token;
            }
            return con;
        }

        public void BulkInsert(DataTable data, SqlTable targetSqlTable, bool CreateTable)
        {
            SqlConnection con = GetSqlConnection();
            con.Open();
            BulkInsert(data, targetSqlTable, CreateTable, con);
            con.Close();
        }

        public static void BulkInsert(DataTable data, SqlTable targetSqlTable, bool CreateTable, SqlConnection con)
        {
            TemporarySqlDestinationTable destTable = new TemporarySqlDestinationTable();
            if (CreateTable == true)
            {
                destTable.CreateTable(TemporarySqlDestinationTable.DropType.DropOnFirstCreateOnly, targetSqlTable.Schema, targetSqlTable.Name, data, con, true, false);
            }

            destTable.BulkInsertTableData(con, targetSqlTable.QuotedSchemaAndName(), data);
        }

        public void AutoBulkInsertAndMerge(DataTable dt, string StagingTableName, string TargetTableName)
        {
            using SqlConnection conn = GetSqlConnection();

            SqlTable sourceSqlTable = new SqlTable
            {
                Name = StagingTableName,
                Schema = null,
                PersistedCon = conn
            };

            SqlTable targetSqlTable = new SqlTable
            {
                Name = TargetTableName,
                Schema = "dbo",
                PersistedCon = conn
            };
            targetSqlTable.GetColumnsFromExistingDb(true);

            BulkInsert(dt, sourceSqlTable, true, conn);
            sourceSqlTable.GetColumnsFromExistingDb(true);

            string primaryKeyJoin = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "a", "b", "=", " and ", true, true, false, false, false, null, false);
            string colList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "=", ",", true, true, false, false, true, null, true);
            string selectListForInsert = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "", ",", true, false, false, false, true, null, true);
            string insertList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "", ",", true, false, false, false, true, null, true);
            string updateClause = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "=", ",", false, false, false, false, true, null, false);


            Dictionary<string, string> sqlParams = new Dictionary<string, string>
            {
                { "TargetFullName", targetSqlTable.QuotedSchemaAndName() },
                { "SourceFullName", sourceSqlTable.QuotedSchemaAndName() },
                { "PrimaryKeyJoin_AB", primaryKeyJoin },
                { "UpdateClause", updateClause },
                { "SelectListForInsert", selectListForInsert },
                { "InsertList", insertList }
            };


            string mergeSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _options.LocalPaths.SQLTemplateLocation), "GenericMerge", sqlParams);

            conn.Execute(mergeSql);
        }
        public string GenerateMergeSql(string StagingTableSchema, string StagingTableName, string TargetTableSchema, string TargetTableName, SqlConnection con, bool CheckSchemaDrift, Logging.Logging logging)
        {
            if (CheckSchemaDrift)
            {
                using SqlCommand sourceCommand = new SqlCommand($"Select * from {StagingTableSchema}.{StagingTableName}", con);
                using SqlDataAdapter sourceAdapter = new SqlDataAdapter(sourceCommand);
                using DataTable stagingDt = new DataTable();
                sourceAdapter.Fill(stagingDt);

                using var targetCommand = new SqlCommand($"Select * from {TargetTableSchema}.{TargetTableName}", con);
                using var targetAdapter = new SqlDataAdapter(targetCommand);
                using DataTable targetDt = new DataTable();
                targetAdapter.Fill(targetDt);

                bool schemaEqual = stagingDt.SchemaEquals(targetDt);

                if (schemaEqual == false)
                {
                    logging.LogWarning($"****Schema Drift for Table {StagingTableSchema}.{StagingTableName?.Replace("#Temp_", "")} to {TargetTableSchema}.{TargetTableName?.Replace("#Temp_", "")}");
                }
            }

            SqlTable sourceSqlTable = new SqlTable
            {
                Name = StagingTableName,
                Schema = StagingTableSchema,
                PersistedCon = con
            };

            SqlTable targetSqlTable = new SqlTable
            {
                Name = TargetTableName,
                Schema = TargetTableSchema,
                PersistedCon = con
            };
            targetSqlTable.GetColumnsFromExistingDb(true);
            sourceSqlTable.GetColumnsFromExistingDb(true);

            string primaryKeyJoin = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "a", "b", "=", " and ", true, true, false, false, false, null, false);
            string colList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "=", ",", true, true, false, false, true, null, true);
            string selectListForInsert = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "", ",", true, false, false, false, true, null, true);
            string insertList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "", ",", true, false, false, false, true, null, true);
            string updateClause = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "=", ",", false, false, false, false, true, null, false);

            Dictionary<string, string> sqlParams = new Dictionary<string, string>
            {
                { "TargetFullName", targetSqlTable.SchemaAndName() },
                { "SourceFullName", sourceSqlTable.SchemaAndName() },
                { "PrimaryKeyJoin_AB", primaryKeyJoin },
                { "UpdateClause", updateClause },
                { "SelectListForInsert", selectListForInsert },
                { "InsertList", insertList }
            };

            string mergeSql;

            if (primaryKeyJoin.Length>=4)
            {
                mergeSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _options.LocalPaths.SQLTemplateLocation), "GenericMerge", sqlParams);
            }
            else
            {
                mergeSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _options.LocalPaths.SQLTemplateLocation), "GenericTruncateInsert", sqlParams);
            }

            return mergeSql;
        }

        public string GenerateInsertSql(string StagingTableSchema, string StagingTableName, string TargetTableSchema, string TargetTableName, SqlConnection con)
        {
            SqlTable sourceSqlTable = new SqlTable
            {
                Name = StagingTableName,
                Schema = StagingTableSchema,
                PersistedCon = con
            };

            SqlTable targetSqlTable = new SqlTable
            {
                Name = TargetTableName,
                Schema = TargetTableSchema,
                PersistedCon = con
            };
            targetSqlTable.GetColumnsFromExistingDb(true);
            sourceSqlTable.GetColumnsFromExistingDb(true);


            string primaryKeyJoin = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "a", "b", "=", " and ", true, true, false, false, false, null, false);
            string colList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "=", ",", true, true, false, false, true, null, true);
            string selectListForInsert = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "", ",", true, false, false, false, true, null, true);
            string insertList = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "", "", "", ",", true, false, false, false, true, null, true);
            string updateClause = Snippets.GenerateColumnJoinOrUpdateSnippet(sourceSqlTable, targetSqlTable, "b", "", "=", ",", false, false, false, false, true, null, false);


            Dictionary<string, string> sqlParams = new Dictionary<string, string>
            {
                { "TargetFullName", targetSqlTable.SchemaAndName() },
                { "SourceFullName", sourceSqlTable.SchemaAndName() },
                { "PrimaryKeyJoin_AB", primaryKeyJoin },
                { "UpdateClause", updateClause },
                { "SelectListForInsert", selectListForInsert },
                { "InsertList", insertList }
            };


            string mergeSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _options.LocalPaths.SQLTemplateLocation), "GenericInsert", sqlParams);

            return mergeSql;
        }

    }

    public static class DataTableSchemaCompare
    {
        public static bool SchemaEquals(this DataTable dt, DataTable value)
        {
            if (dt.Columns.Count != value.Columns.Count)
            {
                return false;
            }

            IEnumerable<DataColumn> dtColumns = dt.Columns.Cast<DataColumn>();
            IEnumerable<DataColumn> valueColumns = value.Columns.Cast<DataColumn>();


            int exceptCount = dtColumns.Except(valueColumns, DataColumnEqualityComparer.Instance).Count();
            return (exceptCount == 0);


        }
    }

    internal class DataColumnEqualityComparer : IEqualityComparer<DataColumn>
    {
        #region IEqualityComparer Members

        private DataColumnEqualityComparer() { }
        public static DataColumnEqualityComparer Instance = new DataColumnEqualityComparer();


        public bool Equals(DataColumn x, DataColumn y)
        {
            if (x.ColumnName != y.ColumnName)
            {
                return false;
            }

            if (x.DataType != y.DataType)
            {
                return false;
            }

            return true;
        }

        public int GetHashCode(DataColumn obj)
        {
            int hash = 17;
            hash = 31 * hash + obj.ColumnName.GetHashCode();
            hash = 31 * hash + obj.DataType.GetHashCode();

            return hash;
        }

        #endregion
    }
}
