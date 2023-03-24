local Template_Execute_VM_Command = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Execute-VM-Command",
        "GFPIR": "N/A",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-13,
        "Pipeline":"Execute_VM_Command"
};



#Execute_VM_Command 
[   
    #dbt

    Template_Execute_VM_Command("VM-N/A","Not-Applicable","VM-N/A","dbt"),

]
