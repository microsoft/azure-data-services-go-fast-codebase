function(TargetType="AzureBlobFS", TargetFormat="DelimitedText")
{
    local formatSettings = {
		"Binary" : import './formatSettings/Binary.libsonnet',
		"DelimitedText" : import './formatSettings/DelimitedText.libsonnet',
		"Excel" : import './formatSettings/Excel.libsonnet',
		"Json" : import './formatSettings/Json.libsonnet',
		"Parquet" : import './/formatSettings/Parquet.libsonnet'
	},

    "type": "%(TargetFormat)sSink" % { TargetFormat:TargetFormat},
    "storeSettings": {
        "type": "%(TargetType)sWriteSettings" % {TargetType:TargetType},
        "copyBehavior": "PreserveHierarchy"
    }
    + formatSettings[TargetFormat]()
}