

Login-AzureRmAccount

Get-AzureRmADServicePrincipal | Remove-AzureRmADServicePrincipal -ObjectId { $_.Id }