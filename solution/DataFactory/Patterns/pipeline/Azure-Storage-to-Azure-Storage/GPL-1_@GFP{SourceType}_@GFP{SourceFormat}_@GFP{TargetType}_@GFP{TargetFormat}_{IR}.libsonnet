
function(GenerateArm="false",GFPIR="IRA",SourceType="SqlServerTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
local Wrapper = import '../static/partials/wrapper.libsonnet';
local ParentPipelineTemplate = import '../static/partials/ParentPipeline.libsonnet';
local Name = if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_" + "', parameters('integrationRuntimeShortName'))]";
local CalledPipelineName = if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+ "_Primary_"+GFPIR 
			else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Primary_" + "', parameters('integrationRuntimeShortName'))]";
local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/Azure-Storage-to-Azure-Storage/" + GFPIR + "/ErrorHandler/"
					else "[concat('ADS Go Fast/Data Movement/Azure-Storage-to-Azure-Storage', parameters('integrationRuntimeShortName'), '/ErrorHandler/')]";

local pipeline = {} + ParentPipelineTemplate(Name, CalledPipelineName, Folder);
	
Wrapper(GenerateArm,pipeline)+{}