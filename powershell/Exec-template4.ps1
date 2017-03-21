
$year = (Get-Date).Year
$month = (Get-Date).Month
$day = (Get-Date).Day

$hour = (Get-Date).Hour
$minute = (Get-Date).Minute
$seconds = (Get-Date).Second

$rgName = "iis2_$year$month$day-$hour$minute$seconds"
$location = "West Europe"

#Write-Host "Resource Group Name: $name"

Login-AzureRmAccount
#Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

New-AzureRmResourceGroup -Name $rgName -Location $location

# -Mode Incremental  || -Mode Complete
New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/iis-2vm-sql-1vm/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/iis-2vm-sql-1vm/azuredeploy.parameters.json -Verbose
