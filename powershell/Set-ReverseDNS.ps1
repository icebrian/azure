
# https://docs.microsoft.com/en-us/azure/dns/dns-reverse-dns-for-azure-services

Login-AzureRmAccount
#Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

$pip = Get-AzureRmPublicIpAddress -Name "icemailrelay-ip" -ResourceGroupName "emailrelay"
$pip.DnsSettings.ReverseFqdn = "azure.icebrian.ml."
Set-AzureRmPublicIpAddress -PublicIpAddress $pip