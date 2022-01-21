function()
local source = import "./Partial_LoadFromExcel.libsonnet";
local target = import "./Partial_LoadIntoSynapse.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
