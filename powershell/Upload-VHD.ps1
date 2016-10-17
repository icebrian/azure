##
## Upload VHD to existing storage account
## Source: https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-upload-image/

# Variables

$subId = "fb8f8229-3cbd-4811-843c-ce7344396f8a"
$rgName = "ic.net"
$urlOfUploadedImageVhd = "https://icnetdata001.blob.core.windows.net/vhdx/pfSense-2-3-2.vhd"
$localFilePath = "C:\Users\iscebria\VMs\HyperV\pfSense\Virtual Hard Disks\pfSense-2-3-2.vhd"

# Script

#Login-AzureRmAccount
Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId $subId

Get-AzureRmStorageAccount

Add-AzureRmVhd -ResourceGroupName $rgName -Destination $urlOfUploadedImageVhd -LocalFilePath $localFilePath