######################################################################################
# Script: 2iis-1sql
# Description: Uses Template file to create 2 Web Server VM's and 1 SQL VM
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

$rgName = "win-xdsk-chef_$year$month$day-$hour$minute$seconds"
$location = "West Europe"

#Write-Host "Resource Group Name: $name"

#Login-AzureRmAccount

New-AzureRmResourceGroup -Name $rgName -Location $location

New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/iis-2vm-sql-1vm/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/iis-2vm-sql-1vm/azuredeploy.parameters.json -Verbose
