
function(GenerateArm="false",GFPIR="",SparkPoolName = "")
local Wrapper = import '../static/partials/wrapper.libsonnet';
local ParentPipelineTemplate = import '../static/partials/ParentPipeline.libsonnet';
local Name = if(GenerateArm=="false") 
			then "GPL_"+"SparkNotebookExecution"+"_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+"SparkNotebookExecution"+"_" + "', parameters('integrationRuntimeShortName'))]";
local CalledPipelineName = if(GenerateArm=="false") 
			then "GPL_"+"SparkNotebookExecution"+ "_Primary_"+GFPIR 
			else "[concat('GPL_"+"SparkNotebookExecution"+"_Primary_" + "', parameters('integrationRuntimeShortName'))]";
local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/" + GFPIR + "/ErrorHandler/"
					else "[concat('ADS Go Fast/', parameters('integrationRuntimeShortName'), '/ErrorHandler/')]";

local pipeline = {} + ParentPipelineTemplate(Name, CalledPipelineName, Folder);
	
Wrapper(GenerateArm,pipeline)+{}