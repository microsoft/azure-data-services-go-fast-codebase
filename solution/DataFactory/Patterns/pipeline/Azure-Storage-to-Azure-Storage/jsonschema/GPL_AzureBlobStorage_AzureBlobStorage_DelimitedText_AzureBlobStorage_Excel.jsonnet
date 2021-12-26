function()
local source = import "./Partial_DelimitedText.libsonnet";
local target = import "./Partial_Excel.libsonnet";
local main = import "./Main.libsonnet";
main(source(),target())
