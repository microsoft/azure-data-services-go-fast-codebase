using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Helpers
{
    public static class SqlDataTypeHelper
    {

        /// <summary>
        /// 
        /// https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql-server-data-type-mappings?redirectedfrom=MSDN
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformSqlTypesToDotNetFramework(string DataType, string NumericPrecision)
        {

            switch (DataType)
            {
                case "bigint": return "Int64";
                case "binary": return "Byte[]";
                case "bit": return "Boolean";
                case "char": return "String";
                case "CHAR": return "String";
                case "date": return "DateTime";
                case "datetime": return "DateTime";
                case "datetime2": return "DateTime";
                case "datetimeoffset": return "DateTimeOffset";
                case "decimal": return "Decimal";
                case "FILESTREAM attribute (varbinary(max))": return "Byte[]";
                case "float": return "Double";
                case "image": return "Byte[]";
                case "int": return "Int32";
                case "money": return "Decimal";
                case "nchar": return "String";
                case "ntext": return "String";
                case "numeric": return "Decimal";
                case "nvarchar": return "String";
                case "real": return "Single";
                case "rowversion": return "Byte[]";
                case "smalldatetime": return "DateTime";
                case "smallint": return "Int16";
                case "smallmoney": return "Decimal";
                case "text": return "String";
                case "time": return "TimeSpan";
                case "timestamp": return "Byte[]";
                case "tinyint": return "Byte";
                case "uniqueidentifier": return "Guid";
                case "varbinary": return "Byte[]";
                case "varchar": return "String";
                case "xml": return "Xml";
                case "VARCHAR2": return "String";
                case "NVARCHAR2": return "String";
                case "FLOAT": return "Double";
                case "LONG": return "Double";
                case "DATE": return "DateTime";
                case "BINARY_FLOAT": return "DECIMAL";
                case "BINARY_DOUBLE": return "DECIMAL";
                case "RAW": return "String";
                case "LONG RAW": return "String";
                case "NUMBER":
                    switch (NumericPrecision) 
                    {
                        case "1": return "Boolean";
                        case "3": return "Boolean";
                        default: 
                            return "Int64";
                    }                
                case "TIMESTAMP": return "Byte[]";

                default:
                    throw new Exception(DataType.ToString() +
                                        " conversion not implemented. Please add conversion logic to TransformSQLTypesToDotNetFramework");
            }
        }

        /// <summary>
        /// 
        /// https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql-server-data-type-mappings?redirectedfrom=MSDN
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformDotNetFrameworTypeToSql(string DataType)
        {

            switch (DataType)
            {
                case "Int64": return "bigint";
                case "Byte[]": return "binary";
                case "Boolean": return "bit";
                case "DateTime": return "datetime2";
                case "DateTimeOffset": return "datetimeoffset";
                case "Decimal": return "decimal";
                case "Double": return "float";
                case "Int32": return "int";
                case "String": return "nvarchar";
                case "Single": return "real";
                case "Int16": return "smallint";
                case string s when s.StartsWith("Object*"): return "sql_variant";
                case "TimeSpan": return "time";
                case "Byte": return "tinyint";
                case "Guid": return "uniqueidentifier";
                case "Xml": return "xml";

                default:
                    throw new Exception(DataType.ToString() +
                                        " conversion not implemented. Please add conversion logic to TransformDotNetFrameworTypeToSQL");
            }
        }

        /// <summary>
        /// 
        /// https://drill.apache.org/docs/parquet-format/#sql-types-to-parquet-logical-types
        /// https://docs.microsoft.com/en-us/azure/data-factory/supported-file-formats-and-compression-codecs-legacy
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformSqlTypesToParquet(string DataType, String NumericPrecision)
        {

            switch (DataType)
            {
                case "bigint": return "Int64";
                case "binary": return "Binary";
                case "bit": return "Boolean";
                case "char": return "UTF8";
                case "CHAR": return "UTF8";
                case "nchar": return "UTF8";
                case "ntext": return "UTF8";
                case "nvarchar": return "UTF8";
                case "text": return "UTF8";
                case "varchar": return "UTF8";
                case "date": return "Int96";
                case "datetime": return "Int96";
                case "datetime2": return "Int96";
                case "datetimeoffset": return "Int96";
                case "smalldatetime": return "Int96";
                case "time": return "TIME_MILLIS";
                case "timestamp": return "TIMESTAMP_MILLIS";
                case "decimal": return "DECIMAL";
                case "money": return "DECIMAL";
                case "numeric": return "DECIMAL";
                case "smallmoney": return "DECIMAL";
                case "float": return "DECIMAL";
                case "image": return "Binary";
                case "int": return "INT32";
                case "real": return "DECIMAL";
                case "rowversion": return "Binary";
                case "smallint": return "INT16";
                case "tinyint": return "INT8";
                case "uniqueidentifier": return "Binary";
                case "varbinary": return "Binary";
                case "xml": return "Binary";
                case "VARCHAR2": return "UTF8";
                case "NVARCHAR2": return "UTF8";
                case "FLOAT": return "DECIMAL";
                case "LONG": return "DECIMAL";
                case "DATE": return "Int96";
                case "BINARY_FLOAT": return "DECIMAL";
                case "BINARY_DOUBLE": return "DECIMAL";
                case "RAW": return "UTF8";
                case "LONG RAW": return "UTF8";
                case "NUMBER":
                    switch (NumericPrecision) 
                    {
                        case "1": return "Boolean";
                        case "3": return "Boolean";
                        default: 
                            return "Int64";
                    }
                case "TIMESTAMP": return "Int96";
                default:
                    throw new Exception(DataType.ToString() +
                                        " conversion not implemented. Please add conversion logic to TransformSQLTypesToParquet");
            }
        }




        public static JObject CreateMappingBetweenSourceAndTarget(JArray arr, string sourceType, string targetType, string metadataType)
        {
            JObject header = new JObject
            {
                ["type"] = "TabularTranslator",
                ["typeConversion"] = true
            };

            JObject typeConversionSettings = new JObject
            {
                ["allowDataTruncation"] = true,
                ["treatBooleanAsNumber"] = false
            };

            header["typeConversionSettings"] = typeConversionSettings;

            List<JObject> obj = new List<JObject>();

            foreach (JObject r in arr)
            {
                JObject mappings = new JObject();
                JObject source = new JObject();
                JObject sink = new JObject();

                if (metadataType == "SQL" && (sourceType == "Azure SQL" || sourceType == "SQL Server" || sourceType == "Azure Synapse" || sourceType == "Oracle Server") && (targetType == "Azure Blob" || targetType == "ADLS"))
                {
                    source["name"] = r["COLUMN_NAME"].ToString();
                    source["type"] = TransformSqlTypesToDotNetFramework(r["DATA_TYPE"].ToString(), r["NUMERIC_PRECISION"].ToString());
                    source["physicalType"] = r["DATA_TYPE"].ToString();

                    sink["name"] = TransformParquetFileColName(r["COLUMN_NAME"].ToString());
                    sink["type"] = TransformSqlTypesToParquet(r["DATA_TYPE"].ToString(), r["NUMERIC_PRECISION"].ToString());
                    sink["physicalType"] = r["DATA_TYPE"].ToString();
                }
                else if (metadataType == "Parquet" && (sourceType == "Azure Blob" || sourceType == "ADLS") && (targetType == "SQL Server" || targetType == "Azure SQL" || targetType == "Azure Synapse" || targetType == "Oracle Server" || targetType == "Table"))
                {
                    source["name"] = TransformParquetFileColName(r["COLUMN_NAME"].ToString());
                    source["type"] = TransformSqlTypesToParquet(r["DATA_TYPE"].ToString(), r["NUMERIC_PRECISION"].ToString());
                    source["physicalType"] = r["DATA_TYPE"].ToString();

                    sink["name"] = r["COLUMN_NAME"].ToString();
                    sink["type"] = TransformSqlTypesToDotNetFramework(r["DATA_TYPE"].ToString(), r["NUMERIC_PRECISION"].ToString());
                    sink["physicalType"] = r["DATA_TYPE"].ToString();
                }

                mappings["source"] = source;
                mappings["sink"] = sink;
                obj.Add(mappings);
            }
            header["mappings"] = JToken.FromObject(obj);

            JObject root = new JObject
            {
                ["value"] = header
            };

            return root;
        }

        public static string TransformParquetFileColName(string FieldName)
        {
            //Replace space
            string fieldName = string.Concat(FieldName.Where(c => !char.IsWhiteSpace(c)));

            //Remove Special characters
            fieldName = string.Concat(fieldName.Select(c => "*!'\",&#^@?{}()[];+= ".Contains(c) ? "" : c.ToString()));
            return fieldName;
        }
    }
}
