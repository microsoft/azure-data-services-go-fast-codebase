local Target = {
    "AzureSqlTable" : import './types/azuresql.libsonnet',
    "AzureSqlDWTable" : import './types/synapse.libsonnet'	
};


function(TargetType="AzureSqlDWTable", allowPolyBase=false)
Target[TargetType](allowPolyBase)
