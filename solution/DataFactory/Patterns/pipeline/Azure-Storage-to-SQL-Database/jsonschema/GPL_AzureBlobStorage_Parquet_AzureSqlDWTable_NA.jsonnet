function()
local source = import "./Partial_LoadFromParquet.libsonnet";
local target = import "./Partial_LoadIntoSqlDW.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
