######################################################################################
# Description: Created unique resource group and deployes specified templated with
# specified parameters
# Author: Istvan Cebrian / Date: 17/01/2016
# Version: 0.1
######################################################################################

$day = (Get-Date).Day

$month = (Get-Date).Month
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minute = (Get-Date).Minute
$seconds = (Get-Date).Second

$rgName = "octo_$year$month$day-$hour$minute$seconds"
$location = "West Europe"

#Write-Host "Resource Group Name: $name"

#Login-AzureRmAccount
#Get-AzureRmSubscription
#Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

New-AzureRmResourceGroup -Name $rgName -Location $location

New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/vm-octopus-tentacle/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/vm-octopus-tentacle/azuredeploy.parameters.json -Verbose
