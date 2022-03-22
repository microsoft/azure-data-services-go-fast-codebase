/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using FormatWith;
using FunctionApp.DataAccess;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Helpers
{
    public class SqlTable
    {
        public SqlConnection PersistedCon { get; set; }

        private bool _colsPopulated = false;

        public string ConString { get; set; }
        public void DropTable()
        {
            string sql = "";
            if (Name.Contains("#"))
            {
                sql = @" IF object_id('tempdb.." + Name + @"') IS NOT NULL
                                    BEGIN
                                        DROP TABLE [" + Name + @"]
                                    END";
            }
            else
            {
                sql = string.Format(@" IF object_id('[{0}].[{1}]') IS NOT NULL
                                    BEGIN
                                        DROP TABLE [{0}].[{1}]
                                    END", Schema, Name);
            }

            using (SqlConnection con = new SqlConnection(ConString))
            {
                con.ExecuteWithRetry(sql);
            }
        }

        public string Schema { get; set; }

        public string Name { get; set; }

        public string QuotedSchemaAndName()
        {
            if (Name.Contains("#"))
            {
                return @"[" + Name + "]";
            }
            else
            {
                return @"[" + Schema + "].[" + Name + "]";
            }
        }

        public string SchemaAndName()
        {
            if (Name.Contains("#"))
            {
                return Name;
            }
            else
            {
                return Schema + "." + Name;
            }
        }

        public bool ExistsInDb()
        {
            using (SqlConnection conn = new SqlConnection(ConString))
            {
                string sql = $@"
                          SELECT
                                  COUNT(*)
                                FROM
                                  sys.tables t
                                JOIN
                                  sys.schemas s
                                    ON t.schema_id = s.schema_id
                                WHERE
                                  s.name = '{Schema}' AND t.name = '{Name}'";
                using SqlCommand cmd = new SqlCommand(sql, conn);
                int retCount = cmd.ExecuteScalarIntWithRetry();
                if (retCount == 1)
                { return true; }
                else
                { return false; }
            }
        }

        private List<SqlColumnDetails> _columns = new List<SqlColumnDetails>();

        public List<SqlColumnDetails> GetColumnsFromExistingDb(bool ForceRefresh)
        {
            if (_colsPopulated && ForceRefresh == false)
            {
                return _columns;
            }
            else
            {
                List<SqlColumnDetails> ret = new List<SqlColumnDetails>();

                if (PersistedCon == null)
                {
                    using (SqlConnection con = new SqlConnection(ConString))
                    {
                        ret = GetColumnsFromExistingDb(ForceRefresh, con);
                    }
                }
                else
                {
                    ret = GetColumnsFromExistingDb(ForceRefresh, PersistedCon);
                }
                _columns = ret;
                _colsPopulated = true;
                return ret;
            }

        }

        private List<SqlColumnDetails> GetColumnsFromExistingDb(bool ForceRefresh, SqlConnection Con = null)
        {
            if (_colsPopulated && ForceRefresh == false)
            {
                return _columns;
            }
            else
            {
                List<SqlColumnDetails> ret = new List<SqlColumnDetails>();
                string sql = "";

                if (Name.StartsWith("#") == false)
                {

                    sql = $@"
                            SELECT
                                c.ORDINAL_POSITION,
                                c.COLUMN_NAME,
                                c.DATA_TYPE,
                                IS_NULLABLE = cast(case when c.IS_NULLABLE = 'Yes' then 1 else 0 END as bit),
                                c.NUMERIC_PRECISION,
                                c.CHARACTER_MAXIMUM_LENGTH,
                                c.NUMERIC_SCALE,
                                is_identity = case when COLUMNPROPERTY(object_id(t.TABLE_SCHEMA+'.'+t.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity') = 1 THEN 1 else 0 END,
                                is_computed = case when COLUMNPROPERTY(object_id(t.TABLE_SCHEMA+'.'+t.TABLE_NAME), c.COLUMN_NAME, 'IsComputed') = 1 THEN 1 else 0 END,
                                KEY_COLUMN = cast(CASE WHEN kcu.TABLE_NAME IS NULL THEN 0 ELSE 1 END as bit)
                            FROM INFORMATION_SCHEMA.COLUMNS c with (NOLOCK)
                            INNER JOIN INFORMATION_SCHEMA.tables t with (NOLOCK) on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA and c.TABLE_CATALOG = c.TABLE_CATALOG
                            LEFT OUTER join INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu with (NOLOCK) ON c.TABLE_CATALOG = kcu.TABLE_CATALOG and c.TABLE_SCHEMA = kcu.TABLE_SCHEMA AND c.TABLE_NAME = kcu.TABLE_NAME and c.COLUMN_NAME = kcu.COLUMN_NAME
                            WHERE t.TABLE_NAME = '{Name}' AND t.TABLE_SCHEMA = '{Schema}'               
                        ";
                }
                else
                {
                    sql = $@"     
                          SELECT
                             c.ORDINAL_POSITION,
                             c.COLUMN_NAME,
                             c.DATA_TYPE,
                             IS_NULLABLE = cast(case when c.IS_NULLABLE = 'Yes' then 1 else 0 END as bit),
                             c.NUMERIC_PRECISION,
                             c.CHARACTER_MAXIMUM_LENGTH,
                             c.NUMERIC_SCALE,
                             is_identity = case when COLUMNPROPERTY(object_id('tempdb..'+QUOTENAME(t.TABLE_NAME)), c.COLUMN_NAME, 'IsIdentity') = 1 THEN 1 else 0 END,
                             is_computed = case when COLUMNPROPERTY(object_id('tempdb..'+QUOTENAME(t.TABLE_NAME)), c.COLUMN_NAME, 'IsComputed') = 1 THEN 1 else 0 END,
                             KEY_COLUMN = cast(CASE WHEN kcu.TABLE_NAME IS NULL THEN 0 ELSE 1 END as bit)
                        FROM Tempdb.INFORMATION_SCHEMA.COLUMNS c with (NOLOCK)

                        INNER JOIN Tempdb.INFORMATION_SCHEMA.tables t with (NOLOCK) on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA and c.TABLE_CATALOG = c.TABLE_CATALOG

                        LEFT OUTER join Tempdb.INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu with (NOLOCK) ON c.TABLE_CATALOG = kcu.TABLE_CATALOG and c.TABLE_SCHEMA = kcu.TABLE_SCHEMA AND c.TABLE_NAME = kcu.TABLE_NAME and c.COLUMN_NAME = kcu.COLUMN_NAME

                        WHERE object_id('tempdb..'+QUOTENAME(t.Table_name)) = object_id('tempdb..'+'{Name}') 
                        ";
                }
                
                IEnumerable<SqlColumnDetails> res = Con.QueryWithRetry<SqlColumnDetails>(sql);


                foreach (SqlColumnDetails c in res)
                {
                    c.ColumnName = c.ColumnName.ToLower();
                    ret.Add(c);
                }

                _columns = ret;
                _colsPopulated = true;
                return ret;
            }

        }

        
    }


    public class SqlColumnDetails
    {
        public string OrdinalPosition { get; set; }
        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public bool IsNullable { get; set; }
        public bool IsComputed { get; set; }
        public bool IsIdentity { get; set; }
        public int NumericPrecision { get; set; }
        public int CharacterMaximumLength { get; set; }
        public int NumericScale { get; set; }
        public bool KeyColumn { get; set; }
    }
    
    public static class Snippets
    {
        public static string GenerateColumnJoinOrUpdateSnippet(SqlTable sourceSqlTable, SqlTable targetSqlTable, string SourceAlias, string TargetAlias, string BooleanOperator, string Concatenator, bool IncludePrimaryKeys, bool IncludeIdentities, bool IncludeCalculatedColumns, bool IncludeAdhocColumnList, bool IncludeOtherColumns, List<string> AdhocColumnList, bool SourceListOnly)
        {
            string output = "";
            bool clusteredIndexColumn = false;

            foreach (var c in sourceSqlTable.GetColumnsFromExistingDb(false))
            {

                if (c.DataType.ToLower() != "timestamp" && c.IsComputed == false) //Exclude all timestamp and calculated columns
                {
                    if (targetSqlTable.GetColumnsFromExistingDb(false).Exists(x => x.ColumnName == c.ColumnName)) //SqlColumnDetails Exists in Both Source and Target
                    {
                        SqlColumnDetails cTarget = targetSqlTable.GetColumnsFromExistingDb(false).Find(x => x.ColumnName == c.ColumnName);
                        clusteredIndexColumn = false;

                        if (cTarget.KeyColumn)
                        {
                            clusteredIndexColumn = true;
                        }

                        if (
                              (IncludeAdhocColumnList && AdhocColumnList.Contains(cTarget.ColumnName) == false) //AdhocInclusionExclusion
                            || (IncludeIdentities && cTarget.IsIdentity == true)  //IdentityInclusion
                            || (IncludePrimaryKeys && (cTarget.KeyColumn || clusteredIndexColumn == true))  //IdentityInclusion
                            || (IncludeCalculatedColumns && cTarget.IsComputed == true)  //ComputedInclusion
                            || (cTarget.KeyColumn == false && cTarget.IsIdentity == false && cTarget.IsComputed == false && IncludeOtherColumns == true) //Include other columns
                           )
                        {
                            output = (output == "" ? "" : output + Concatenator);

                            if (!(SourceListOnly))
                            {
                                output = output
                                            + (TargetAlias == "" ? "" : TargetAlias + ".")
                                            + (string.Concat("[", c.ColumnName, "]") + " ")
                                            + (BooleanOperator + " ");
                            }

                            output = output
                                        + (SourceAlias == "" ? "" : SourceAlias + ".")
                                         + (string.Concat("[", c.ColumnName, "]"));
                        }
                    }
                }
            }
            return output;
        }
    }
    

    public static class GenerateSqlStatementTemplates
    {
        public static string GetSql(string PathReference, string FileReference, Dictionary<string, string> Params)
        {
            string sql = System.IO.File.ReadAllText(PathReference + FileReference + ".sql");
            sql = sql.FormatWith(Params, MissingKeyBehaviour.ThrowException, null, '{', '}');
            return sql;
        }

        public static string GetCreateTable(JArray Array, string TargetTableSchema, string TargetTableName, string TargetType, bool DropIfExist)
        {
            string dropIfExistStatement = null;
            string createSchema = null;
            if (!TargetTableName.Contains("#"))
            {
                if (DropIfExist == true)
                {
                    dropIfExistStatement = string.Format(@"IF EXISTS(SELECT* FROM sys.objects WHERE object_id = OBJECT_ID(N'[{0}].[{1}]') AND type in (N'U'))
                    BEGIN
                        DROP TABLE [{0}].[{1}]
                    END " + Environment.NewLine, TargetTableSchema, TargetTableName);
                }
                else
                {
                    dropIfExistStatement = string.Format(@"IF NOT EXISTS(SELECT* FROM sys.objects WHERE object_id = OBJECT_ID(N'[{0}].[{1}]') AND type in (N'U'))
                    BEGIN
                        DROP TABLE [{0}].[{1}]
                    " + Environment.NewLine, TargetTableSchema, TargetTableName);
                }

                if (!TargetTableSchema.Equals("dbo"))
                {
                    createSchema = string.Format(@"
                    if not exists(select 1 from information_schema.schemata where schema_name='{0}')
                    BEGIN
                        EXEC ('CREATE SCHEMA {0} AUTHORIZATION dbo;')
                    END
                    " + Environment.NewLine, TargetTableSchema);
                }
            }

            string createStatement = string.Format(@"Create Table [{0}].[{1}] (" + Environment.NewLine, TargetTableSchema, TargetTableName);
            string createStatementPk = null;
            int lengthCounter = 0;
            List<string> PkeyCols = new List<string>();
            foreach (JObject r in Array)
            {
                lengthCounter = lengthCounter + 1;
                string sqlType = "varchar(max)";

                sqlType = r["DATA_TYPE"].ToString();
                string np = r["NUMERIC_PRECISION"].ToString();
                string ns = r["NUMERIC_SCALE"].ToString();
                string cml = r["CHARACTER_MAXIMUM_LENGTH"].ToString();

                if (sqlType.Contains("varchar") || sqlType.Contains("varbinary"))
                {
                    cml = (cml == "-1") ? "Max" : cml;
                }

                if (sqlType.ToLower().Contains("uniqueidentifier") && TargetType == "Azure Synapse")
                {
                    sqlType = "nvarchar";
                    cml = "36";
                }

                if (sqlType.Contains("xml"))
                {
                    cml = null;
                }

                if ((np != "" || ns != "") && sqlType.Equals("decimal"))
                {
                    sqlType += " (";
                    if (np != null) { sqlType += np + ","; } else { sqlType += "0,"; };
                    if (ns != null) { sqlType += ns + ")"; } else { sqlType += "0)"; };
                }

                if (cml != "" && cml != null)
                {
                    sqlType += "(" + cml + ")";
                }

                string nullableFlag = "";
                if (Convert.ToBoolean(r["IS_NULLABLE"])) { nullableFlag = "null"; } else { nullableFlag = "not null"; };

                createStatement += string.Format("[{0}] {1} {2}" + Environment.NewLine, r["COLUMN_NAME"].ToString(), sqlType, nullableFlag);
                if (lengthCounter < Array.Count) { createStatement += ","; };

                string kc = r["PKEY_COLUMN"].ToString();

                if (kc.Equals("True") && (TargetType == "Azure SQL" || TargetType == "SQL Server"))
                {
                    if (createStatementPk == null)
                    {
                        createStatementPk = string.Format(@"CONSTRAINT [PK_{0}_{1}] PRIMARY KEY CLUSTERED (" + Environment.NewLine, TargetTableSchema, TargetTableName);
                    }

                    createStatementPk += $"[{r["COLUMN_NAME"].ToString()}],";
                }

                if (kc.Equals("True") && (TargetType == "Azure Synapse"))
                {
                    if (createStatementPk == null)
                    {
                        createStatementPk = string.Format(@"CONSTRAINT [PK_{0}_{1}] PRIMARY KEY NONCLUSTERED (" + Environment.NewLine, TargetTableSchema, TargetTableName);
                    }

                    createStatementPk += $"[{r["COLUMN_NAME"].ToString()}]";
                }
            }
            if (createStatementPk != null)
            {
                createStatementPk = createStatementPk.TrimEnd(new char[] { ',' }) + ")";
                if (TargetType == "Azure Synapse")
                {
                    createStatementPk = createStatementPk + " NOT ENFORCED ";
                }
                createStatementPk = createStatementPk + Environment.NewLine;
            }

            createStatement += Environment.NewLine + createStatementPk + ")";

            if (DropIfExist == true || TargetTableName.Contains("#"))
            {
                createStatement = dropIfExistStatement + createSchema + createStatement;
            }
            else
            {
                createStatement = dropIfExistStatement + createSchema + createStatement + Environment.NewLine + "END";
            }

            return createStatement;

        }

    }


}
