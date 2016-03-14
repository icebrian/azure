

$day = (Get-Date).Day

$month = (Get-Date).Month
$year = (Get-Date).Year
$hour = (Get-Date).Hour
$minute = (Get-Date).Minute
$seconds = (Get-Date).Second

$rgName = "diskraid_$year$month$day-$hour$minute$seconds"
$location = "West Europe"

#Login-AzureRmAccount

New-AzureRmResourceGroup -Name $rgName -Location $location

New-AzureRmResourceGroupDeployment -Name $rgName -ResourceGroupName $rgName -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/diskraid-ubuntu-vm/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/diskraid-ubuntu-vm/azuredeploy.parameters.json -Verbose
