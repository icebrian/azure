######################################################################################
# Template with Extensions
######################################################################################

Login-AzureRmAccount

Get-AzureVMAvailableExtension | select ExtensionName,Publisher,Version,PublishedDate

New-AzureRmResourceGroupDeployment -Name "cm-arm" -ResourceGroupName "cm-arm" -TemplateUri https://raw.githubusercontent.com/icebrian/azure/master/templates/puppet-agent-windows/azuredeploy.json -TemplateParameterUri https://raw.githubusercontent.com/icebrian/azure/master/templates/puppet-agent-windows/azuredeploy.parameters.json -Verbose
