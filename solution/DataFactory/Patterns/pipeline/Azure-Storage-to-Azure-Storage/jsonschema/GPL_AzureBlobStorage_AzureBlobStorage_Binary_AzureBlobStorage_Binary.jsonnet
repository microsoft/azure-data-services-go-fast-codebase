function()
local source = import "./Partial_Binary.libsonnet";
local target = import "./Partial_Binary.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
