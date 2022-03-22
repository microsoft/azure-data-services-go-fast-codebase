
function(GenerateArm="false",GFPIR="IRA",SourceType="SqlServerTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
local Wrapper = import '../static/partials/wrapper.libsonnet';
local ParentPipelineTemplate = import '../static/partials/ParentPipeline.libsonnet';
local Name = if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_NA_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_NA_" + "', parameters('integrationRuntimeShortName'))]";
local CalledPipelineName = if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_NA_Primary_"+GFPIR 
			else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_NA_Primary_" + "', parameters('integrationRuntimeShortName'))]";
local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/Azure-Storage-to-SQL-Database/" + GFPIR + "/ErrorHandler/"
					else "[concat('ADS Go Fast/Data Movement/Azure-Storage-to-SQL-Database/', parameters('integrationRuntimeShortName'), '/ErrorHandler/')]";

local pipeline = {} + ParentPipelineTemplate(Name, CalledPipelineName, Folder);
	
Wrapper(GenerateArm,pipeline)+{}