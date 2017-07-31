#Step 1 – Setup your PowerShell environment

#Sign in to your account for the Resource Manager model.
Login-AzureRmAccount

#Set your Azure subscription for the current session
#$subID=Get-AzureRmSubscription|Select-AzureRmSubscription
$subID="fb8f8229-3cbd-4811-843c-ce7344396f8a"
Select-AzureRmSubscription -SubscriptionId $subID

#Get the available subscriptions by using the following command
#Get-AzureRMSubscription | Sort SubscriptionName | Select SubscriptionName

#Set your Azure subscription for the current session. Replace everything within the quotes with the correct names.
#$subscr="Microsoft Azure Enterprise"
#Get-AzureRmSubscription –SubscriptionName $subscr | Select-AzureRmSubscription

#Register with the migration resource provider.
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate

#check the registration
Get-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate

#sign in the classic model
Add-AzureAccount
$subID="fb8f8229-3cbd-4811-843c-ce7344396f8a"
Set-AzureSubscription -SubscriptionId $subID

#Step 2 – Prepare your environment
#Prepare the virtual network for migration
$vnetName = "Group unicretest unicretest"
Move-AzureVirtualNetwork -Prepare -VirtualNetworkName $vnetName

#Step 3 – Commit or Abort the migration
#abort and roll back the preparation
Move-AzureVirtualNetwork -Abort -VirtualNetworkName $vnetName

#Commit the migration
Move-AzureVirtualNetwork -Commit -VirtualNetworkName $vnetName


# Storage

Move-AzureStorageAccount -Prepare -StorageAccountName "1nportalvhds6qflfmspvh4j"

Move-AzureStorageAccount -Commit -StorageAccountName "1nportalvhds6qflfmspvh4j"

#https://1nportalvhds6qflfmspvh4j.blob.core.windows.net/vhds/unicretest10-unicretest1-2017-07-31.vhd

#$storageAccountName = 'yourStorageAccountName'
#  Get-AzureDisk | where-Object {$_.MediaLink.Host.Contains($storageAccountName)} | Select-Object -ExpandProperty AttachedTo -Property `
#  DiskName | Format-List -Property RoleName, DiskName


#Get-AzureRmVMDiagnosticsExtension -ResourceGroupName "HomeBankingProd" -VMName "AZUPRDHBASYNC" 