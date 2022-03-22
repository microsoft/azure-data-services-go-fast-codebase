
function(generatearm="true", pipeline={ "kjsajd":"test"})
local armt = import 'armwrapper.libsonnet';
if (generatearm=="true") then armt{pipeline: pipeline}
else 
pipeline