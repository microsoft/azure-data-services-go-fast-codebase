/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using Dapper;

namespace FunctionApp.DataAccess
{
    public static class TransientDapperExtensions
    {
        public static void OpenWithRetry(this SqlConnection connection)
        {
            if (connection == null)
                throw new ArgumentException("Connection can't be null");
            int maxRetry = 3;
            for (int i = 0; i < maxRetry; i++)
            {
                try
                {
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    i = maxRetry;
                    System.Threading.Thread.Sleep(2000);
                }
                catch (SqlException e)
                {
                    DetermineIfRetry(e, ref i, maxRetry);

                }
            }
        }

        public static void ExecuteWithRetry(this SqlConnection connection, string Query)
        {
            if (connection == null)
                throw new ArgumentException("Connection can't be null");

            connection.ExecuteWithRetry(Query, 30);
        }

        public static void ExecuteWithRetry(this SqlConnection connection, string Query, int Timeout)
        {
            if (connection == null)
                throw new ArgumentException("Connection can't be null");

            int maxRetry = 3;
            for (int i = 0; i < maxRetry; i++)
            {
                try
                {
                    connection.Execute(Query,null,null, Timeout,null);
                    i = maxRetry;                   
                }
                catch (SqlException e)
                {
                    if (DetermineIfRetry(e, ref i, maxRetry) == false) { i = maxRetry; };
                    if (i != maxRetry)
                    { System.Threading.Thread.Sleep(2000); }
                }
            }
        }

        public static bool DetermineIfRetry(SqlException e, ref int i, int MaxRetry)
        {
            bool ret = false;

            string logEvent = "SQL Exception Number: " + e.Number.ToString() + ". Error was  " + e.Message.ToString();

            if ((e.Number == 53 || e.Number == 40) && (i < MaxRetry))
            {
                ret = true;
            }
            else
            {
                //Non Retry Error
                i = MaxRetry;
                throw new Exception(logEvent);
            }

            return ret;

        }

        public static IEnumerable<T> QueryWithRetry<T>(
            this SqlConnection connection, string sql, object param = null, IDbTransaction transaction = null,
            bool buffered = true, int? commandTimeout = null, CommandType? commandType = null
            )
        {
            if (connection == null)
                throw new ArgumentException("Connection can't be null");

            if (connection.State == ConnectionState.Closed)
            {
                connection.OpenWithRetry();
            }

            return connection.Query<T>(sql, param, transaction, buffered, commandTimeout, commandType);

        }

        public static dynamic QueryWithRetry(
        this SqlConnection connection, string sql, object param = null, IDbTransaction transaction = null,
            bool buffered = true, int? commandTimeout = null, CommandType? commandType = null
            )
        {
            if (connection == null)
                throw new ArgumentException("Connection can't be null");

            if (connection.State == ConnectionState.Closed)
            {
                connection.OpenWithRetry();
            }

            return connection.Query(sql, param, transaction, buffered, commandTimeout, commandType);

        }
    }

    public static class SqlExtensionMethods
    {
        public static int ExecuteNonQueryWithVerboseThrow(this SqlCommand Cmd)
        {

            int ret = 0;
            try
            {
                Cmd.Connection.OpenWithRetry();
                int maxRetry = 3;
                for (int i = 0; i < maxRetry; i++)
                {
                    try
                    {
                        Cmd.ExecuteNonQuery();
                        //Utilities.StaticMethods.LogProvider.GetLog().Info("SqlExecution Succeeded.. Exiting Retry Loop");
                        i = maxRetry;
                    }
                    catch (SqlException e)
                    {
                        if (TransientDapperExtensions.DetermineIfRetry(e, ref i, maxRetry) == false) { i = maxRetry; };
                    }
                }

            }
            catch (SqlException e)
            {
                if (e.Number == -2)
                {
                    //Logging.LogErrors(new Exception(String.Format("Timeout during execution of SQL:{0}. Timeout was set to {1}", Cmd.CommandText.ToString(), Cmd.CommandTimeout.ToString())));
                    throw new Exception("Timeout during execution of SQL:" + Cmd.CommandText.ToString() + ". Timeout was set to " + Cmd.CommandTimeout.ToString());

                }
                else
                {
                    //Logging.LogErrors(new Exception(String.Format("Timeout during execution of SQL:{0}. Error was {1}", Cmd.CommandText.ToString(), e.Message.ToString())));
                    throw new Exception("Error during execution of SQL:" + Cmd.CommandText.ToString() + ". Error was  " + e.Message.ToString());
                }
            }
            return ret;
        }


        public static int ExecuteScalarIntWithRetry(this SqlCommand Cmd)
        {

            int ret = 0;
            try
            {
                Cmd.Connection.OpenWithRetry();
                int maxRetry = 3;
                for (int i = 0; i < maxRetry; i++)
                {
                    try
                    {
                        ret = Convert.ToInt16(Cmd.ExecuteScalar());
                        //Logging.LogInformation("SqlExecution Succeeded.. Exiting Retry Loop");
                        i = maxRetry;
                    }
                    catch (SqlException e)
                    {
                        if (TransientDapperExtensions.DetermineIfRetry(e, ref i, maxRetry) == false) { i = maxRetry; };
                    }
                }

            }
            catch (SqlException e)
            {
                if (e.Number == -2)
                {
                    throw new Exception("Timeout during execution of SQL:" + Cmd.CommandText.ToString() + ". Timeout was set to " + Cmd.CommandTimeout.ToString());
                }
                else
                {
                    //Logging.LogErrors(new Exception(String.Format("Timeout during execution of SQL:{0}. Error was {1}", Cmd.CommandText.ToString(), e.Message.ToString())));
                    throw new Exception("Error during execution of SQL:" + Cmd.CommandText.ToString() + ". Error was  " + e.Message.ToString());
                }
            }
            return ret;
        }

    }

    public static class ListExtensionMethods
    {
        public static DataTable ToDataTable<T>(this IEnumerable<T> pItems)
        {
            DataTable dt = new DataTable();
            T[] data = pItems as T[] ?? pItems.ToArray();
            T fieldNameRow = data.First();

            foreach (PropertyInfo pInfo in fieldNameRow.GetType().GetProperties(BindingFlags.Public | BindingFlags.Instance))
            {
                Type type;
                //ToDo: Add error if this fails
                if (pInfo.PropertyType.FullName.Contains("Nullable"))
                {
                    type = Nullable.GetUnderlyingType(pInfo.PropertyType);

                }
                else
                {
                    type = Type.GetType(pInfo.PropertyType.FullName);
                }

                dt.Columns.Add(pInfo.Name, type);
            }

            foreach (T result in data)
            {
                DataRow nr = dt.NewRow();
                foreach (PropertyInfo pi in result.GetType().GetProperties(BindingFlags.Public | BindingFlags.Instance))
                {
                    if (pi.GetValue(result, null) == null)
                    {
                        nr[pi.Name] = DBNull.Value;
                    }
                    else
                    {
                        nr[pi.Name] = pi.GetValue(result, null);
                    }
                }
                dt.Rows.Add(nr);
            }

            return dt;

        }
    }

}
