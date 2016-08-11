

Login-AzureRmAccount

Get-AzureRmSubscription

#Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a
Select-AzureRmSubscription -SubscriptionId c5574319-d49a-4acf-a21d-f4d6de436b4f

#Settings wont work, puppet.confg in c:\ProgramData needs to be manually updated
Set-AzureRmVMExtension -ResourceGroupName demo-config-mgmt01  -Location 'westeurope' -VMName dcfgmgmt-wpuppc -Name PuppetEnterpriseAgent -Publisher 'PuppetLabs' -ExtensionType 'PuppetEnterpriseAgent' -TypeHandlerVersion '3.8'

#-Settings @{"puppet_master_server" = "dcfgmgmt-lin-puppetsrv.westeurope.cloudapp.azure.com";} -Debug
