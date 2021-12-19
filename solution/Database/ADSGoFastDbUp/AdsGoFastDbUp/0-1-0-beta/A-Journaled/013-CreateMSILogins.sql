        DROP USER IF EXISTS [$FunctionAppName$] 
        CREATE USER [$FunctionAppName$] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$FunctionAppName$];
        ALTER ROLE db_datawriter ADD MEMBER [$FunctionAppName$];
        ALTER ROLE db_ddladmin ADD MEMBER [$FunctionAppName$];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$FunctionAppName$];
        GO 

        DROP USER IF EXISTS [$WebAppName$] 
        CREATE USER [$WebAppName$] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$WebAppName$];
        ALTER ROLE db_datawriter ADD MEMBER [$WebAppName$];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$WebAppName$];
        GO

        DROP USER IF EXISTS [$DataFactoryName$] 
        CREATE USER [$DataFactoryName$] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$DataFactoryName$];
        ALTER ROLE db_datawriter ADD MEMBER [$DataFactoryName$];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$DataFactoryName$];
        GO