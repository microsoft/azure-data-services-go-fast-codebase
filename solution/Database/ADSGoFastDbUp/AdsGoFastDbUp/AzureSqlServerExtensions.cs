using System;
using DbUp.Builder;
using DbUp.SqlServer;



/// <summary>Configuration extension methods for Azure SQL Server.</summary>
// NOTE: DO NOT MOVE THIS TO A NAMESPACE
// Since the class just contains extension methods, we leave it in the global:: namespace so that it is always available
// ReSharper disable CheckNamespace
public static class AzureSqlServerExtensions
{

    /// <summary>Creates an upgrader for Azure SQL Databases using Azure AD Integrated Security.</summary>
    /// <param name="supported">Fluent helper type.</param>
    /// <param name="connectionString">The connection string.</param>
    /// <param name="schema">The SQL schema name to use. Defaults to 'dbo' if <see langword="null" />.</param>
    /// <returns>A builder for a database upgrader designed for Azure SQL Server databases.</returns>
    public static UpgradeEngineBuilder AzureSqlDatabaseWithIntegratedSecurity(this SupportedDatabases supported, string connectionString, string schema)
    {
        return supported.SqlDatabase(new AzureSqlConnectionManager(connectionString), schema);
    }
}
