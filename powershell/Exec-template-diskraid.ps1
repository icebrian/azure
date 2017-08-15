######################################################################################
# Script:
# Description:
# Author: Istvan Cebrian / Date: 15/03/2016
# Version: 0.1
######################################################################################

$day = (Get-Date).Day

$month = (Get-Date).Month
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minute = (Get-Date).Minute
$seconds = (Get-Date).Second

$rgName = "diskraid_$year$month$day-$hour$minute$seconds"
$location = "West Europe"

Login-AzureRmAccount

Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

New-AzureRmResourceGroup -Name $rgName -Location $location

New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/datadisks-ubuntu-vm/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/datadisks-ubuntu-vm/azuredeploy.parameters.json -Verbose
