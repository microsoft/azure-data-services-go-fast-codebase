function()
local source = import "./Partial_LoadFromDelimitedText.libsonnet";
local target = import "./Partial_LoadIntoSynapse.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
