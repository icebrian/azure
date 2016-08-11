#Login-AzureRmAccount
#Get-AzureRmSubscription
#Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

# Create VM from an existing image

$location = "westeurope"
$vmSize = "Standard_DS2"

#Existing resource name parameters:
$rgName = "iscebria"
$vnetName= "iscebria-VNET"
$stName = "lrstor1linstd"
#This vhd is a copy of a completely working ARM OS vhd:
$vhdUri = "https://lrstor1linstd.blob.core.windows.net/copiedvhds/testcopy1.vhd"

#Newly creatable resource names and other parameters
$vmName = "vm-wp-02"
$nicName="vmni-wp-02"
$pipName="vmpip-wp-02"
$nsgName="vmnsg-wp-02"
$vhdName = "vmdisk-wp-02"

$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName
$storageAccount = Get-AzureRmStorageAccount -AccountName $stName -ResourceGroupName $rgName

$pip = New-AzureRmPublicIpAddress -Name $pipName -ResourceGroupName $rgName -Location $location -AllocationMethod Static -DomainNameLabel $pipName
$nsg = New-AzureRmNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName -Location $location
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# Configure VM:
$vm = New-AzureRmVMConfig -vmName $vmName -vmSize $vmSize
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $vhdName -VhdUri $vhdUri -Linux -CreateOption attach

New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm
