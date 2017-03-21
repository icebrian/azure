# Deploy SF Package

##
## Connect & Publish v1
##

Import-Module "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\Tools\PSModule\ServiceFabricSDK\ServiceFabricSDK.psm1"

#Connect-ServiceFabricCluster localhost:19000
Connect-ServiceFabricCluster icsf.westeurope.cloudapp.azure.com:19000

#Publish-NewServiceFabricApplication -ApplicationPackagePath c:\ServiceFabric\WordCountV1.sfpkg -ApplicationName "fabric:/WordCount"
Publish-NewServiceFabricApplication -ApplicationPackagePath c:\ServiceFabric\VisualObjectsV1.sfpkg -ApplicationName "fabric:/VisualObjects"

## HTTP
# Wordcount    : http://localhost:8081/wordcount/
# VisualObjects: http://10.0.0.8:8081/visualobjects/

##
## Get Details
##

Get-ServiceFabricApplication

#Get-ServiceFabricService -ApplicationName 'fabric:/WordCount'
Get-ServiceFabricService -ApplicationName 'fabric:/VisualObjects'

#Get-ServiceFabricPartition 'fabric:/WordCount/WordCountService'
Get-ServiceFabricPartition 'fabric:/VisualObjects/VisualObjects.WebService'

##
## Upgrade to v2
##

#Publish-UpgradedServiceFabricApplication -ApplicationPackagePath C:\ServiceFabric\WordCountV2.sfpkg -ApplicationName "fabric:/WordCount" -UpgradeParameters @{"FailureAction"="Rollback"; "UpgradeReplicaSetCheckTimeout"=1; "Monitored"=$true; "Force"=$true}
Publish-UpgradedServiceFabricApplication -ApplicationPackagePath C:\ServiceFabric\VisualObjectsV2.sfpkg -ApplicationName "fabric:/VisualObjects" -UpgradeParameters @{"FailureAction"="Rollback"; "UpgradeReplicaSetCheckTimeout"=1; "Monitored"=$true; "Force"=$true}

#Get-ServiceFabricService -ApplicationName 'fabric:/WordCount'
Get-ServiceFabricService -ApplicationName 'fabric:/VisualObjects'


##
## Unpublish/Clean-up (same as Reset Local Cluster)
##

#Unpublish-ServiceFabricApplication -ApplicationName "fabric:/WordCount" # Same as delete
Unpublish-ServiceFabricApplication -ApplicationName "fabric:/VisualObjects" # Same as delete

#Remove-ServiceFabricApplicationType -ApplicationTypeName WordCount -ApplicationTypeVersion 2.0.0 # Same as Unprovision Type
#Remove-ServiceFabricApplicationType -ApplicationTypeName WordCount -ApplicationTypeVersion 1.0.0
Remove-ServiceFabricApplicationType -ApplicationTypeName VisualObjects -ApplicationTypeVersion 2.0.0 # Same as Unprovision Type
Remove-ServiceFabricApplicationType -ApplicationTypeName VisualObjects -ApplicationTypeVersion 1.0.0