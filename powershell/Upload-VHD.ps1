## DOES NOT WORK!


# Upload VHD to Blob storage

#Login-AzureRmAccount
Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a
Set-AzureRmStorageAccount -ResourceGroupName ic.net -Name icvhdx -

Set-AzureSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a -CurrentStorageAccountName icvhdx

$DestFile = "https://icvhdx.blob.core.windows.net/blob1/pfSense-2.2.3-amd64.vhd"
$SourceFile = "C:\Users\iscebria\VMs\HyperV\pfSense\Virtual Hard Disks\pfSense-2-3-2.vhd"
 
# VHD Upload
Add-AzureRmVhd -Destination $DestFile -LocalFilePath $SourceFile

# Create an Image
Add-AzureVMImage -ImageName "pfSense-2.3.2" -MediaLocation $DestFile -OS Linux