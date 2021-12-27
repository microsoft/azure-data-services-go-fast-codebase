function()
local source = import "./Partial_Excel.libsonnet";
local target = import "./Partial_Parquet.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
