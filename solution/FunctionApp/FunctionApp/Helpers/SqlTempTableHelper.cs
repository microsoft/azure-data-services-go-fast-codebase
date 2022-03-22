/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using FunctionApp.DataAccess;

namespace FunctionApp.Helpers
{

    public class TemporarySqlDestinationTable
    {
        public bool TableCreated { get; set; }
        public bool DataInserted { get; set; }

        public TemporarySqlDestinationTable()
        {
            TableCreated = false;
            DataInserted = false;
        }

        public enum DropType { DropAlways, DropOnFirstCreateOnly, DontDrop };

        public void CreateTable(DropType DropType, string TempTableSchemaNoQuotes, string TempTableNameNoQuotes, DataTable DataTbl, SqlConnection conn, bool AddPkey, bool forceString)
        {
            string sql = "";
            if ((DropType == DropType.DropAlways) || ((DropType == DropType.DropOnFirstCreateOnly) && (TableCreated == false)))
            {
                if (TempTableNameNoQuotes.StartsWith("#"))
                {
                    sql = @" IF object_id('tempdb.." + TempTableNameNoQuotes + @"') IS NOT NULL
                                    BEGIN
                                        DROP TABLE [" + TempTableNameNoQuotes + @"]
                                    END";
                }
                else
                {
                    sql = string.Format(@" IF object_id('[{0}].[{1}]') IS NOT NULL
                                    BEGIN
                                        DROP TABLE [{0}].[{1}]
                                    END", TempTableSchemaNoQuotes, TempTableNameNoQuotes);
                }
                using var dropCommand= new SqlCommand(sql, conn);
                dropCommand.ExecuteNonQueryWithVerboseThrow();
            }

            if (TableCreated == false)
            {
                sql = SqlTableCreator.GetCreateFromDataTableSql(TempTableSchemaNoQuotes, TempTableNameNoQuotes, DataTbl, false, forceString);
                using var createTableCommand = new SqlCommand(sql, conn);
                createTableCommand.ExecuteNonQueryWithVerboseThrow();
                sql = "";
                if (AddPkey)
                {
                    if (TempTableNameNoQuotes.StartsWith("#"))
                    {
                        sql =
                            $@"Alter Table [{TempTableNameNoQuotes}] add [Pkey{Guid.NewGuid().ToString()}] bigint identity(1,1) PRIMARY KEY CLUSTERED";
                    }
                    else
                    {
                        sql =
                            $@"Alter Table [{TempTableSchemaNoQuotes}].[{TempTableNameNoQuotes}] add [Pkey{Guid.NewGuid().ToString()}] bigint identity(1,1) PRIMARY KEY CLUSTERED";
                    }
                    using var alterCommand = new SqlCommand(sql, conn);
                    alterCommand.ExecuteNonQueryWithVerboseThrow();
                }
                TableCreated = true;
            }
        }

        /// <summary>
        /// Bulk insert DataTable rows in to the specified SQL Table
        /// </summary>
        /// <param name="sqlConnection">SQL Connection</param>
        /// <param name="destSqlTableName">Destination SQL Table name</param>
        /// <param name="dataTable">DataTable woth rows to insert in DB</param>
        public void BulkInsertTableData(SqlConnection sqlConnection, string destSqlTableName, DataTable dataTable)
        {
            int bcTimeOut = 260;
            try
            {
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConnection, SqlBulkCopyOptions.FireTriggers, null))
                {
                    bulkCopy.BulkCopyTimeout = bcTimeOut;
                    bulkCopy.DestinationTableName = destSqlTableName;
                    bulkCopy.WriteToServer(dataTable);
                    bulkCopy.Close();
                    DataInserted = true; // indicate copying completed successfully
                }
            }
            catch (SqlException e)
            {
                DataInserted = false;
                if (e.Number == -2)
                {
                    throw new Exception("Timeout during bulk copy of TempTable:" + destSqlTableName + ". Timeout was set to " + bcTimeOut.ToString() + "; RowCount of incoming Table: " + dataTable.Rows.Count.ToString());
                }
                else
                {
                    throw new Exception("Error during bulk copy of TempTable:" + destSqlTableName + ". Error was  " + e.Message.ToString() + "; RowCount of incoming Table: " + dataTable.Rows.Count.ToString());
                }
            }




        }
    }

    public class SqlTableCreator
    {
        #region Instance Variables
        private SqlConnection _connection;
        public SqlConnection Connection
        {
            get => _connection;
            set => _connection = value;
        }

        private SqlTransaction _transaction;
        public SqlTransaction Transaction
        {
            get => _transaction;
            set => _transaction = value;
        }

        private string _tableName;
        public string DestinationTableName
        {
            get => _tableName;
            set => _tableName = value;
        }
        #endregion

        #region Constructor
        public SqlTableCreator(SqlConnection connection, SqlTransaction transaction)
        {
            _connection = connection;
            _transaction = transaction;
        }
        #endregion

        #region Instance Methods
        public object Create(DataTable schema, bool forceString)
        {
            return Create(schema, null, forceString);
        }
        public object Create(DataTable schema, int numKeys, bool forceString)
        {
            int[] primaryKeys = new int[numKeys];
            for (int i = 0; i < numKeys; i++)
            {
                primaryKeys[i] = i;
            }
            return Create(schema, primaryKeys, forceString);
        }
        public object Create(DataTable schema, int[] primaryKeys, bool forceString)
        {
            string sql = GetCreateSql(_tableName, schema, primaryKeys, forceString);

            SqlCommand cmd;
            if (_transaction != null && _transaction.Connection != null)
            {
                cmd = new SqlCommand(sql, _connection, _transaction);
            }
            else
            {
                cmd = new SqlCommand(sql, _connection);
            }

            return cmd.ExecuteNonQueryWithVerboseThrow();
        }

        public object CreateFromDataTable(DataTable table, bool forceString)
        {
            string sql = GetCreateFromDataTableSql("dbo", _tableName, table, forceString);

            SqlCommand cmd;
            if (_transaction != null && _transaction.Connection != null)
            {
                cmd = new SqlCommand(sql, _connection, _transaction);
            }
            else
            {
                cmd = new SqlCommand(sql, _connection);
            }

            return cmd.ExecuteNonQueryWithVerboseThrow();
        }
        #endregion

        #region Static Methods

        public static string GetCreateSql(string tableName, DataTable schema, int[] primaryKeys, bool forceString)
        {
            string sql = "CREATE TABLE " + tableName + " (\n";

            // columns
            foreach (DataRow column in schema.Rows)
            {
                if (!(schema.Columns.Contains("IsHidden") && (bool)column["IsHidden"]))
                {
                    sql += column["ColumnName"].ToString() + " " + SqlGetType(column, forceString) + ",\n";
                }
            }
            sql = sql.TrimEnd(new char[] { ',', '\n' }) + "\n";

            // primary keys
            string pk = "CONSTRAINT PK_" + tableName + " PRIMARY KEY CLUSTERED (";
            bool hasKeys = (primaryKeys != null && primaryKeys.Length > 0);
            if (hasKeys)
            {
                // user defined keys
                foreach (int key in primaryKeys)
                {
                    pk += schema.Rows[key]["ColumnName"].ToString() + ", ";
                }
            }
            else
            {
                // check schema for keys
                string keys = string.Join(", ", GetPrimaryKeys(schema));
                pk += keys;
                hasKeys = keys.Length > 0;
            }
            pk = pk.TrimEnd(new char[] { ',', ' ', '\n' }) + ")\n";
            if (hasKeys)
            {
                sql += pk;
            }

            sql += ")";

            return sql;
        }

        public static string GetCreateFromDataTableSql(string TableSchema, string tableName, DataTable table, bool forceString)
        {
            return GetCreateFromDataTableSql(TableSchema, tableName, table, true, forceString);
        }
        public static string GetCreateFromDataTableSql(string TableSchema, string tableName, DataTable table, bool IncludePrimaryKey, bool forceString)
        {

            string sql = "";

            if (tableName.StartsWith("#"))
            {
                sql = "CREATE TABLE [" + tableName + @"] (" + Environment.NewLine;
            }
            else
            {
                sql = "CREATE TABLE [" + TableSchema + "].[" + tableName + @"] (" + Environment.NewLine;
            }

            // columns
            foreach (DataColumn column in table.Columns)
            {
                sql += "[" + column.ColumnName + "] " + SqlGetType(column, forceString) + "," + Environment.NewLine;
            }
            sql = sql.TrimEnd(new char[] { ',' }) + Environment.NewLine;
            // primary keys
            if ((table.PrimaryKey.Length > 0) && (IncludePrimaryKey == true))
            {
                sql += "CONSTRAINT [PK_" + TableSchema + "_" + tableName + "] PRIMARY KEY CLUSTERED (";
                foreach (DataColumn column in table.PrimaryKey)
                {
                    sql += "[" + column.ColumnName + "],";
                }
                sql = sql.TrimEnd(new char[] { ',' }) + "))" + Environment.NewLine;
            }
            else
            {
                sql += ")";
            }
            return sql;
        }

        public static string[] GetPrimaryKeys(DataTable schema)
        {
            List<string> keys = new List<string>();

            foreach (DataRow column in schema.Rows)
            {
                if (schema.Columns.Contains("IsKey") && (bool)column["IsKey"])
                {
                    keys.Add(column["ColumnName"].ToString());
                }
            }

            return keys.ToArray();
        }

        // Return T-SQL data type definition, based on schema definition for a column
        public static string SqlGetType(object type, int columnSize, int numericPrecision, int numericScale, bool forceString)
        {
            string typestring = type.ToString();
            typestring = typestring.Replace("System.", "");
            typestring = typestring.ToLower();


            if (forceString)
            {
                return "NVARCHAR(MAX)";
            }
            else
            {
                switch (typestring)
                {
                    case "string":
                        return "VARCHAR(" + ((columnSize == -1) ? "MAX" : columnSize.ToString()) + ") COLLATE database_default ";

                    case "decimal":
                        if (numericScale > 0)
                        {
                            return "REAL";
                        }
                        else if (numericPrecision > 10)
                        {
                            return "BIGINT";
                        }
                        else
                        {
                            return "INT";
                        }

                    case "double":
                    case "single":
                        return "REAL";

                    case "int64":
                        return "BIGINT";

                    case "int16":
                    case "int32":
                    case "int":
                        return "INT";

                    case "tinyint":
                        return "INT";

                    case "byte":
                        return "INT";

                    case "datetime":
                        return "DATETIME";

                    case "datetimeoffset":
                        return "DATETIMEOFFSET";

                    case "bit":
                    case "boolean":
                        return "BIT";

                    case "guid":
                        return "UNIQUEIDENTIFIER";
                    case "byte[]":
                        return "VARBINARY";
                    case "timespan":
                        return "TIME(7)";
                    case "SByte":
                        return "TINYINT";
                    case "uint64":
                        return "BIGINT";
                    case "uint32":
                        return "INT";


                    default:
                        throw new Exception(type.ToString() + " conversion not implemented. Please add conversion logic to SQLGetType");
                }
            }
        }

        // Overload based on row from schema table
        public static string SqlGetType(DataRow schemaRow, bool forceString)
        {
            return SqlGetType(schemaRow["DataType"],
                                int.Parse(schemaRow["ColumnSize"].ToString()),
                                int.Parse(schemaRow["NumericPrecision"].ToString()),
                                int.Parse(schemaRow["NumericScale"].ToString()),
                                forceString);
        }
        // Overload based on DataColumn from DataTable type
        public static string SqlGetType(DataColumn column, bool forceString)
        {
            return SqlGetType(column.DataType, column.MaxLength, 10, 2, forceString);
        }
        #endregion
    }




}


