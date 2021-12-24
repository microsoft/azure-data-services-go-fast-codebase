
function(SourceFormat="DelimitedText")
{
    local formatSettings = {
		"Binary" : import './formatSettings/Binary.libsonnet',
		"DelimitedText" : import './formatSettings/DelimitedText.libsonnet',
		"Excel" : import './formatSettings/Excel.libsonnet',
		"Json" : import './formatSettings/Json.libsonnet',
		"Parquet" : import './formatSettings/Parquet.libsonnet'
	},
    local storeSettings = {
		"Binary" : import './storeSettings/Binary.libsonnet',
		"DelimitedText" : import './storeSettings/DelimitedText.libsonnet',
		"Excel" : import './storeSettings/Excel.libsonnet',
		"Json" : import './storeSettings/Json.libsonnet',
		"Parquet" : import './storeSettings/Parquet.libsonnet'
	},    
    "type": "%(TargetFormat)sSource" % { TargetFormat: SourceFormat },
    "storeSettings": storeSettings[SourceFormat](),
    "formatSettings": formatSettings[SourceFormat](),
}