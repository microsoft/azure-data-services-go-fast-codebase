function()
{
    "name": "Azure-Integration-Runtime",
    "properties": {
        "type": "Managed",
        "typeProperties": {
            "computeProperties": {
                "location": "Australia East",
                "dataFlowProperties": {
                    "computeType": "General",
                    "coreCount": 8,
                    "timeToLive": 10
                }
            }
        },
        "managedVirtualNetwork": {
            "type": "ManagedVirtualNetworkReference",
            "referenceName": "default"
        }
    }
}