from diagrams import Cluster, Diagram, Edge
from diagrams.azure.compute import FunctionApps
from diagrams.azure.analytics import SynapseAnalytics
from diagrams.azure.database import DataFactory
from diagrams.azure.network import VirtualNetworks
from diagrams.azure.network import Subnets
from diagrams.azure.network import NetworkSecurityGroupsClassic
from diagrams.azure.storage import StorageAccounts
from diagrams.generic.database import SQL
from diagrams.custom import Custom
from urllib.request import urlretrieve
import cairosvg


#Get Custom Icons
cairosvg.svg2png(url="https://raw.githubusercontent.com/benc-uk/icon-collection/master/azure-icons/Private-Link.svg", write_to="./icons/Private-Link.png", output_height=200, output_width=200)
cairosvg.svg2png(url="https://raw.githubusercontent.com/benc-uk/icon-collection/master/azure-icons/Private-Link-Hub.svg", write_to="./icons/Private-Link-Hub.png", output_height=200, output_width=200)
#cairosvg.svg2png(url="https://raw.githubusercontent.com/benc-uk/icon-collection/master/azure-icons/Private-Link.svg", write_to="./icons/Private-Link.png", output_height=200, output_width=200)
#cairosvg.svg2png(url="https://raw.githubusercontent.com/benc-uk/icon-collection/master/azure-icons/Private-Link.svg", write_to="./icons/Private-Link.png", output_height=200, output_width=200)
#cairosvg.svg2png(url="https://raw.githubusercontent.com/benc-uk/icon-collection/master/azure-icons/Private-Link.svg", write_to="./icons/Private-Link.png", output_height=200, output_width=200)

graph_attr = {
    "fontsize": "45"
}

node_attr = {
    "fontsize": "11"
}

with Diagram("Azure Analytics", show=False):
    with Cluster("On-Premises"):
        opdatabase = SQL("Sql Server",fontsize="10")
        datafactoryira = DataFactory("Integration Runtime",fontsize="10") 
        sources = [opdatabase,datafactoryira ]
    
    with Cluster("Azure"):
        transientin = StorageAccounts("Transient In",fontsize="10")
        transientout = StorageAccounts("Transient Out",fontsize="10")
        azitems = [
            transientin,
            transientout
            ]

        with Cluster("Virtual Network"):
            vnet1 = VirtualNetworks("Virtual Network",fontsize="10")
            datalake = StorageAccounts("Data Lake",fontsize="10")
            SynapseWorkspace = SynapseAnalytics("Synapse",fontsize="10")
            PrivateEndPoint = Custom("Private Link", "./icons/Private-Link.png")
            vnetitems = [vnet1,datalake, SynapseWorkspace]

    opdatabase \
        >> datafactoryira 
    
    datafactoryira \
        >> Edge(label="Express Route", color="red") \
        >> vnet1 \
        >> datalake

    datafactoryira \
        >> Edge(label="https", color="blue") \
        >> transientin >> vnet1 >> datalake >> SynapseWorkspace

   