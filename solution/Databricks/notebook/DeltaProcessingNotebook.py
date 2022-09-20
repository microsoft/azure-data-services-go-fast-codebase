# Databricks notebook source
TaskObject = """{"TaskInstanceId": 37,
    "TaskMasterId": -1000,
    "TaskStatus": "InProgress",
    "TaskType": "Azure Storage to Azure Storage",
    "Enabled": 1,
    "ExecutionUid": "9d06d8c7-9184-4bee-9605-62142e22781c",
    "NumberOfRetries": 0,
    "DegreeOfCopyParallelism": 1,
    "KeyVaultBaseUrl": "https://ads-stg-kv-ads-r6p7.vault.azure.net/",
    "ScheduleMasterId": "-4",
    "TaskGroupConcurrency": "10",
    "TaskGroupPriority": 0,
    "TaskExecutionType": "ADF",
    "ExecutionEngine": {
        "EngineId": -2,
        "EngineName": "adsstgsynwadsr6p7",
        "SystemType": "Synapse",
        "ResourceGroup": "gfuat2",
        "SubscriptionId": "035a1364-f00d-48e2-b582-4fe125905ee3",
        "ADFPipeline": "GPL_SparkNotebookExecution_Azure",
        "EngineJson": {"endpoint": "https://adsstgsynwadsr6p7.dev.azuresynapse.net", "DeltaProcessingNotebook": "DeltaProcessingNotebook", "PurviewAccountName": "adsstgpuradsr6p7", "DefaultSparkPoolName":"adsstgsynspads"},
        "TaskDatafactoryIR": "Azure",
        "JsonProperties": {
            "endpoint": "https://adsstgsynwadsr6p7.dev.azuresynapse.net",
            "DeltaProcessingNotebook": "DeltaProcessingNotebook",
            "PurviewAccountName": "adsstgpuradsr6p7",
            "DefaultSparkPoolName": "adsstgsynspads"
        }
    },
    "Source": {
        "System": {
            "SystemId": -4,
            "SystemServer": "https://adsstgdlsadsr6p7adsl.dfs.core.windows.net",
            "AuthenticationType": "MSI",
            "Type": "ADLS",
            "Username": null,
            "Container": "datalakeraw"
        },
        "Instance": {
            "SourceRelativePath": "samples/SalesLT_Customer_CDC/",
            "TargetRelativePath": "/Tests/Azure Storage to Azure Storage/-1000/"
        },
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/SalesLT_Customer_CDC/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "Type": "Parquet",
        "WriteSchemaToPurview": "Disabled"
    },
    "Target": {
        "System": {
            "SystemId": -4,
            "SystemServer": "https://adsstgdlsadsr6p7adsl.dfs.core.windows.net",
            "AuthenticationType": "MSI",
            "Type": "ADLS",
            "Username": null,
            "Container": "datalakeraw"
        },
        "Instance": {
            "SourceRelativePath": "samples/SalesLT_Customer_CDC/",
            "TargetRelativePath": "/Tests/Azure Storage to Azure Storage/-1000/"
        },
        "DataFileName": "SalesLT.Customer",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/-1000/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Delta",
        "WriteSchemaToPurview": "Disabled"
    },
    "TMOptionals": {
        "CDCSource": "Disabled",
        "Purview": "Disabled",
        "QualifiedIDAssociation": "TaskMasterId",
        "SparkTableCreate": "Disabled",
        "SparkTableDBName": "",
        "SparkTableName": "",
        "UseNotebookActivity": "Disabled"
    }
}"""

# COMMAND ----------

import random
import json
from pyspark.sql import Row
from pyspark.sql.types import *
from pyspark.sql.functions import *
from datetime import date
from datetime import datetime

session_id = random.randint(0,1000000)

TaskObjectJson = json.loads(TaskObject)
Source = TaskObjectJson['Source']['System']['Container'] + "@" + TaskObjectJson['Source']['System']['SystemServer'].replace("https://","") + "/"
Schema = TaskObjectJson['Source']['System']['Container'] + "@" + TaskObjectJson['Source']['System']['SystemServer'].replace("https://","") + "/"
Target = TaskObjectJson['Target']['System']['Container'] + "@" + TaskObjectJson['Target']['System']['SystemServer'].replace("https://","") + "/"


Source = Source + TaskObjectJson['Source']['Instance']['SourceRelativePath'] + "/" + TaskObjectJson['Source']['DataFileName']
Schema = Schema + TaskObjectJson['Source']['Instance']['SourceRelativePath'] + "/" + TaskObjectJson['Source']['SchemaFileName']
Target = Target + TaskObjectJson['Target']['Instance']['TargetRelativePath'] + "/" + TaskObjectJson['Target']['DataFileName']


#remove any double slashes
Source = Source.replace('//', '/')
Schema = Schema.replace('//', '/')
Target = Target.replace('//', '/')

#get source and target data types
SourceDT = TaskObjectJson['Source']['Type']
TargetDT = TaskObjectJson['Target']['Type']


#add abfss
Source = "abfss://" + Source
Schema = "abfss://" + Schema
Target = "abfss://" + Target

now = datetime.now()

Source = Source.replace("{yyyy}", "%Y")
Source = Source.replace("{MM}", "%m")
Source = Source.replace("{dd}", "%d")
Source = Source.replace("{hh}", "%H")
Source = Source.replace("{mm}", "%M")
Source = now.strftime(Source)

Target = Target.replace("{yyyy}", "%Y")
Target = Target.replace("{MM}", "%m")
Target = Target.replace("{dd}", "%d")
Target = Target.replace("{hh}", "%H")
Target = Target.replace("{mm}", "%M")
Target = now.strftime(Target)

Schema = Schema.replace("{yyyy}", "%Y")
Schema = Schema.replace("{MM}", "%m")
Schema = Schema.replace("{dd}", "%d")
Schema = Schema.replace("{hh}", "%H")
Schema = Schema.replace("{mm}", "%M")
Schema = now.strftime(Schema)

print ("Source: " + Source)
print ("Schema: " + Schema)
print ("Target: " + Target)



# COMMAND ----------

Source = "abfss://datalakeraw@adsstgdlsadsr6p7adsl.dfs.core.windows.net/samples/SalesLT_Customer_CDC/SalesLT.Customer*.parquet"

Schema = "abfss://datalakeraw@adsstgdlsadsr6p7adsl.dfs.core.windows.net/samples/SalesLT_Customer_CDC/SalesLT.Customer*.json"

Target = "abfss://datalakeraw@adsstgdlsadsr6p7adsl.dfs.core.windows.net/Tests/Azure Storage to Azure torage/-1000/SalesLT.Customer"

# COMMAND ----------

schema = spark.read.load(Schema, format='json', multiLine=True)
schema

# COMMAND ----------

try:
    print("Schema found - using schema json to find PK")
    schema = spark.read.load(Schema, format='json', multiLine=True)
    #convert it into a list so we can loop it using python rules
    schema = schema.collect()
    #loop through each column to find the primary key column
    for col in schema:
        if col.PKEY_COLUMN:
            print(col.COLUMN_NAME)
            primaryKey = col
            mergeCondition = "oldData." + primaryKey.COLUMN_NAME + " = newData." + primaryKey.COLUMN_NAME
            break
except:
    print("Schema json not found - assuming source dataframe first column is PK")
    df = spark.read.load(Source, format=SourceDT)
    primaryKey = df.columns[0]
    print(primaryKey)
    mergeCondition = "oldData." + primaryKey + " = newData." + primaryKey

#set up the merge condition used in the next code block
print(mergeCondition)

# COMMAND ----------

from delta.tables import *
import pandas as pd
if(TaskObjectJson['TMOptionals']['CDCSource'] == 'Enabled'):
    print("CDC Source")
    df = spark.read.load(Source, format=SourceDT)
    #these are our cdc specific columns
    cdcCols = ["__$start_lsn", "__$end_lsn", "__$seqval", "__$update_mask", "__$operation", "__$command_id"]
    #we are dropping all of the $ / _ as they cause issues with spark SQL functions -> this may be changed to just remove the first 3 chars of each of the cdcCols (__$)
    cdcColsToDrop = ["startlsn", "endlsn", "seqval", "updatemask", "operation", "commandid"]
    #these are columns we want to convert from binary data types to string as dataframes do not play nice with them currently
   #colsToString = ["__$start_lsn", "__$end_lsn", "__$seqval", "__$update_mask"]
    colsToString = ["startlsn", "endlsn", "seqval", "updatemask"]

    for col in cdcCols:
        new_col = col.replace('_','')
        new_col = new_col.replace('$','')
        df = df.withColumnRenamed(col, new_col)

    for col in colsToString: 
        try:
            df = df.withColumn(col, hex(col))
        except:
            print("Error converting the column " + col)

    #convert to pandas dataframe so we can do more manipulation
    pdf = df.toPandas()

    #we want to sort by our start lsn and then by the seqval so that we can drop everything except the most recent database change for every unique row
    try:
        #columns we are sorting by, the LSN and then the sequence value - ensure the latest is at the bottom of the table
        pdf = pdf.sort_values(by=["startlsn", "seqval"])
    except:
        print("error in finding valid sorting columns - skipping.")
    pdf_dedupe = pdf.drop_duplicates(subset=[primaryKey.COLUMN_NAME], keep='last', inplace=False)

    df = spark.createDataFrame(pdf_dedupe)

    #operation 1 is equal to delete, the other 3 operations (inserts old and new / upserts) can be done together
    dfDeletes = df.filter("operation == 1")
    dfUpserts = df.filter("operation != 1")
    #We want to sort our columns by our primary key now that we have only the latest actions
    dfDeletes = dfDeletes.sort(primaryKey.COLUMN_NAME)
    dfUpserts = dfUpserts.sort(primaryKey.COLUMN_NAME)

    #drop unwanted columns -> not needed for our delta table as they are cdc specific
    for col in cdcColsToDrop:
        try:
            dfDeletes = dfDeletes.drop(col)
            dfUpserts = dfUpserts.drop(col)
        except:
            print("Error dropping the column " + col)

    sql = 'describe detail "' + Target + '"'
    try:
        if (spark.sql(sql).collect()[0].asDict()['format'] == 'delta'):
            print("Table already exists. Performing Merge")
            olddt = DeltaTable.forPath(spark, Target)  
            olddt.alias("oldData").merge(
                dfUpserts.alias("newData"),
                mergeCondition) \
            .whenMatchedUpdateAll() \
            .whenNotMatchedInsertAll() \
            .execute()
        else:
            print("Table does not exist. No error, creating new Delta Table.")    
            dfUpserts.write.format("delta").save(Target)
    except: 
        print("Table does not exist, error thrown. Creating new Delta Table. Note - this error can be that no file is found.") 
        dfUpserts.write.format("delta").save(Target)

    olddt = DeltaTable.forPath(spark, Target)  
    olddt.alias("oldData").merge(
    dfDeletes.alias("newData"),
    mergeCondition) \
    .whenMatchedDelete() \
    .execute()  

else:
    print("Non CDC Source")
    if(TargetDT == 'Delta'):
        print("SourceDT = " + SourceDT + ", TargetDT = Delta.")
        df = spark.read.load(Source, format=SourceDT)
        sql = 'describe detail "' + Target + '"'
        try:
            if (spark.sql(sql).collect()[0].asDict()['format'] == 'delta'):
                print("Table already exists. Performing Merge")
                olddt = DeltaTable.forPath(spark, Target)  
                olddt.alias("oldData").merge(
                    df.alias("newData"),
                    mergeCondition) \
                .whenMatchedUpdateAll() \
                .whenNotMatchedInsertAll() \
                .execute()
            else:
                print("Table does not exist. No error, creating new Delta Table.")    
                df.write.format("delta").save(Target)
        except:
            print("Table does not exist. Creating new Delta Table.")    
            df.write.format("delta").save(Target)
    elif(TargetDT == 'Parquet' and SourceDT == 'Delta'):
        print("SourceDT = Delta, TargetDT = Parquet.")
        df = spark.read.format("delta").load(Source)
        df.write.format("parquet").mode("overwrite").save(Target) 

# COMMAND ----------

#This checks if the user wants to save the sink as a persistent table
if(TaskObjectJson['TMOptionals']['SparkTableCreate'] == 'Enabled'):
    print("Creating Spark Table")
    df = spark.read.load(Target, format='delta')
    #targetDB = 'testdb2'
    #targetTable = 'test2'
    #SynapseSnapshots/Workspacename/dbname/tablename.parquet
    #SynapseTarget = Target + '/'+ targetDB + '/' + targetTable
    #SynapseTarget = 'abfss://datalakeraw@' + TaskObjectJson['TMOptionals']['PersistentStorage']
    targetDB = TaskObjectJson['TMOptionals']['SparkTableDBName']
    targetTable = TaskObjectJson['TMOptionals']['SparkTableName']
    #if the target datatype is parquet then we do not need to create a copy of the data - we can use the recently saved sink target
    if (TargetDT == 'Parquet'):
        SnapshotTarget = Target
    else:
        SnapshotTarget = Target + '/'+ TaskObjectJson['TMOptionals']['SparkTableDBName'] + '/' + TaskObjectJson['TMOptionals']['SparkTableName']
        #we need to update the parquet file - this is not very efficient but there isnt a current better way as delta tables are not supported for persistent tables
        df.write.format("parquet").mode("overwrite").save(SnapshotTarget)


    #we need to make the DB and table lowercase as synapse persistent tables dont identify them as different identities
    targetDB = targetDB.lower()
    targetTable = targetTable.lower()

    #check if the specified DB / table exists - if so only do required actions.
    dbList = spark.catalog.listDatabases()
    dbExists = False
    for db in dbList:
        if (db.name == targetDB):
            dbExists = True
            break
    if (dbExists):
        print("DB Exists")
        tableExists = False
        spark.catalog.setCurrentDatabase(targetDB)
        tableList = spark.catalog.listTables()
        for table in tableList:
            if (table.name == targetTable):
                tableExists = True
                break
        if (tableExists):
            print("Table exists - nothing needed to be done")
            spark.catalog.refreshTable(targetTable)
        else:
            print("Table doesnt exist - creating")
            spark.catalog.createExternalTable(targetTable, path=SnapshotTarget, source='parquet')
    else:
        print("DB Doesnt exist - creating DB and table")
        createDBString = "CREATE DATABASE " + targetDB 
        spark.sql(createDBString)
        spark.catalog.setCurrentDatabase(targetDB)
        spark.catalog.createExternalTable(targetTable, path=SnapshotTarget, source='parquet')
else:
    print("Skipping Spark Table creation")

#%%sql
#CREATE TABLE testdb.dbo.test
#USING PARQUET OPTIONS ('path'= 'abfss://datalakeraw@arkstgdlsadsenrzadsl.dfs.core.windows.net/samples/SalesLT.Customer.chunk_2.parquet', 'inferschema'=true);
#select * from testdb.dbo.test limit 10

    

# COMMAND ----------

#olddt.history().show(20, 1000, False)
#display(spark.read.format("delta").load(Target))
#spark.sql("CREATE TABLE SalesLTCustomer USING DELTA LOCATION '{0}'".format(TargetFile))

# COMMAND ----------

## Execute Upsert
#(old_deltaTable
# .alias("oldData") 
# .merge(newIncrementalData.alias("newData"), "oldData.id = newData.id")
# .whenMatchedUpdate(set = {"name": col("newData.name")})
# .whenNotMatchedInsert(values = {"id": col("newData.id"), "name":
#                                col("newData.name")})
# .execute()
#)
#
# Display the records to check if the records are Merged
#display(spark.read.format("delta").load(Target))

# COMMAND ----------

#olddt.history().show(20, 1000, False)

# COMMAND ----------

#########################
#NOTE -> This is an alternate way of upserting into delta table. Using manual method of getting each column required from the schema / dataframe and then creating a dictionary to use for the upsert.
#           Currently not using this however it does work. Would advise to change the script to just create a dictionary and insert that instead of creating a string to convert into a dict.
#########################
#from delta.tables import *
#df = spark.read.load(Source, format='parquet')
#updatecols = []
#insertcols = []
#for col in schema:
#    updatecols.append(col.COLUMN_NAME)
#
#for col in df.dtypes:
#    insertcols.append(col[0])
#
#creating a string to be converted to dictionary 
#note -> can easily re-write this as just a dictionary if end up using this method.
#updatestring = '{'
#insertstring = '{'
#
#Go through each column in the schema to check what needs to be updated
#for col in updatecols:
#    updatestring = updatestring + '"' + col + '": "newData.' + col +'", '
#updatestring = updatestring[:-2]
#updatestring = updatestring + '}'
#
#Go through the new data to check what columns need to be inserted
#for col in insertcols:
#    insertstring = insertstring + '"' + col + '": "newData.' + col +'", '
#insertstring = insertstring[:-2]
#insertstring = insertstring + '}'
#
#print(updatestring)
#print(insertstring)
#
#convert to dict
#res = json.loads(updatestring)
#res2 = json.loads(insertstring)
#
#sql = 'describe detail "' + Target + '"'
#try:
#    if (spark.sql(sql).collect()[0].asDict()['format'] == 'delta'):
#        print("Table already exists. Performing Merge")
#        olddt = DeltaTable.forPath(spark, Target)  
#        olddt.alias("oldData").merge(
#            df.alias("newData"),
#            mergeCondition) \
#        .whenMatchedUpdate(set = res) \
#        .whenNotMatchedInsert(values = res2) \
#        .execute()
#except:
#    print("Table does not exist.")    
#    df.write.format("delta").save(Target)

# COMMAND ----------

#from delta.tables import * 
#import pandas as pd
#Source = 'abfss://datalakeraw@arkstgdlsadsenrzadsl.dfs.core.windows.net/samples/SalesLT.Customer.chunk_1.parquet'
#Target = 'abfss://datalakeraw@arkstgdlsadsenrzadsl.dfs.core.windows.net/samples/SalesLT_Customer_Delta/SalesLT.Customer'
#mergeCondition = "oldData." + "CustomerID" + " = newData." + "CustomerID"

#df = spark.read.load(Source, format='parquet')

#these are our cdc specific columns
#cdcCols = ['__$start_lsn', '__$end_lsn', '__$seqval', '__$operation', '__$update_mask', '__$command_id']

#convert to pandas dataframe so we can do more manipulation
#pdf = df.toPandas()
#we want to sort by our start lsn and then by the seqval so that we can drop everything except the most recent database change for every unique row
#try:
    #columns we are sorting by, the LSN and then the sequence value - ensure the latest is at the bottom of the table
#    pdf = pdf.sort_values(by=['__$start_lsn', '__$seqval'])
#except:
#   print("error in finding valid sorting columns - skipping.")

#df = pdf.drop_duplicates(subset=['CustomerID'], keep='last', inplace=False)
#df_dedupe = pdf.drop_duplicates(subset=[primaryKey.COLUMN_NAME], keep='last', inplace=False)

#df = spark.createDataFrame(df)
#dfDeletes = df.filter("CustomerID < 100")
#dfUpserts = df.filter("CustomerID >= 100")
#dfDeletes = df.filter("__$operation == 1")
#dfUpserts = df.filter("__$operation != 1")

#drop unwanted columns -> not needed for our delta table as they are cdc specific
#for col in cdcCols:
#    try:
#        dfDeletes = dfDeletes.drop(col)
#        dfUpserts = dfUpserts.drop(col)
#    except:
#        print("Error dropping the column " + col)

#sql = 'describe detail "' + Target + '"'
#try:
#    if (spark.sql(sql).collect()[0].asDict()['format'] == 'delta'):
#        print("Table already exists. Performing Merge")
#        olddt = DeltaTable.forPath(spark, Target)  
#        olddt.alias("oldData").merge(
#            dfUpserts.alias("newData"),
#           mergeCondition) \
#        .whenMatchedUpdateAll() \
#        .whenNotMatchedInsertAll() \
#        .execute()
#    else:
#        print("Table does not exist. No error, creating new Delta Table.")    
#       dfUpserts.write.format("delta").save(Target)
#except: 
#    print("Table does not exist, error thrown. Creating new Delta Table.")    
#    dfUpserts.write.format("delta").save(Target)

#olddt = DeltaTable.forPath(spark, Target)  
#olddt.alias("oldData").merge(
#dfDeletes.alias("newData"),
#mergeCondition) \
#.whenMatchedDelete() \
#.execute()  
#display(dfDeletes)

#df.write.format("delta").save(Target)


# COMMAND ----------

#from delta.tables import * 
#import pandas as pd

#df = spark.createDataFrame(["0x0000019600000178002D","0x0000019600000178002D","0x0000019600000178002D", "0x0000019600000178002A"], "string").toDF("hex")
#hex2 = ['0x00000194000000A80002', '0x00000A94000000A80002', '0x00000194000000B80004', '0x00000194000000B80000']

#pdf = df.toPandas()
#pdf['hex2'] = hex2


#df = spark.createDataFrame(pdf)
#df_dedupe = df.dropDuplicates('hex')
#df_dedupe = df.dropDuplicates(primaryKey.COLUMN_NAME)


#pdf['hex'] = pdf['hex'].apply(int, base=16)

#pdf = pdf.sort_values(by=['hex','hex2'])
#show(df_dedupe)

# COMMAND ----------


