function()
local source = import "./Partial_LoadFromSql.libsonnet";
local target = import "./Partial_LoadIntoParquet.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
