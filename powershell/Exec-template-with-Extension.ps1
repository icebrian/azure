######################################################################################
# Script: 2iis-1sql
# Description: Uses Template file to create 1 Windows Server with Puppet Agent installed
# for further information, please refer to:
# - https://azure.microsoft.com/en-us/documentation/templates/iis-2vm-sql-1vm/
# - https://github.com/Azure/azure-quickstart-templates/tree/master/iis-2vm-sql-1vm
# Author: Istvan Cebrian / Date: 17/01/2016
# Version: 0.1
######################################################################################

$day = (Get-Date).Day

$month = (Get-Date).Month
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minute = (Get-Date).Minute
$seconds = (Get-Date).Second

$rgName = "cm-classic"
$location = "East US"

#Write-Host "Resource Group Name: $name"

#Login-AzureRmAccount

#New-AzureRmResourceGroup -Name $rgName -Location $location

New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/puppet-agent-windows/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/puppet-agent-windows/azuredeploy.parameters.json -Verbose
