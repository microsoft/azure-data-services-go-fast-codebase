function()
local source = import "./Partial_LoadFromJson.libsonnet";
local target = import "./Partial_LoadIntoSql.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
