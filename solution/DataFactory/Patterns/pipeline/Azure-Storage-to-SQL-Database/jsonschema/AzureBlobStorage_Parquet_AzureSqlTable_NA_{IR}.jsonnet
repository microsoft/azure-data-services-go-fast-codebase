function()
local parquet = import "./Partial_LoadFromParquet.libsonnet";
local sqlimport = import "./Partial_LoadIntoSql.libsonnet";
local main = import "./Main.libsonnet";
main()
+ parquet()
+ sqlimport()
