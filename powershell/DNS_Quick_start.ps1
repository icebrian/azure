# https://azure.microsoft.com/en-gb/documentation/articles/dns-getstarted-create-dnszone/
# https://azure.microsoft.com/en-gb/documentation/articles/dns-getstarted-create-recordset/

Login-AzureRmAccount

Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

New-AzureRmResourceGroup -Name DNSResourceGroup -location "West Europe"

Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Network

# Tags are different from Etags. Tags are a list of name-value pairs, and are used by Azure Resource Manager 
# to label resources for billing or grouping purposes. For more information about Tags see using tags to organize 
# your Azure resources. Azure DNS PowerShell supports Tags on both zones and record sets specified using the options 
# ‘-Tag’ parameter. The following example shows how to create a DNS zone with two tags, ‘project = demo’ and ‘env = test’:

New-AzureRmDnsZone -Name contoso.com -ResourceGroupName DNSResourceGroup -Tag @( @{ Name="project"; Value="demo" }, @{ Name="env"; Value="test" } )

Get-AzureRmDnsRecordSet -ZoneName contoso.com -ResourceGroupName DNSResourceGroup