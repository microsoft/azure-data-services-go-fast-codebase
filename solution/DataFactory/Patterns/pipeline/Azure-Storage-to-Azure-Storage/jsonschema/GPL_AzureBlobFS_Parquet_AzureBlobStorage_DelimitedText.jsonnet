function()
local source = import "./Partial_Parquet.libsonnet";
local target = import "./Partial_DelimitedText.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
