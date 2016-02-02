
# Login into Azure
Login-AzureRmAccount

# Subscriptions
Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

# Get All Available Locations with Machine Sizes
Get-AzureLocation

# Get Available Virtual Machine Sizes in Central US and stor into $storagelocations
$storagelocations = Get-AzureLocation | select Name | where {$_.VirtualMachineRoleSizes -cle "Standard_D14_v2"}

# Randomly select a location and display
$justlocations = $storagelocations.Name
"Random Region=" + (Get-Random -input $justlocations)

# Define $region variable with random selection
$region=(Get-Random -input $justlocations)

# Create Resource Group and Storage Account
$rgname="VMinCode"
$storagename="iscebriavmdiskstore"
New-AzureRmResourceGroup -Name $rgname -Location $region
New-AzureRmStorageAccount –Name $storagename –Location $region -ResourceGroupName $rgname -Type Standard_LRS

# Create and configure Networking
$vmDNSname="iscebria-vmincode"
$subnetName="Subnet-1"
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.64.0/24"
$vnet = New-AzureRmVirtualNetwork -Name "VNET" -ResourceGroupName $rgname -Location $region -AddressPrefix "10.0.0.0/16" -Subnet $subnet
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $rgname -Name "vip1" -Location $region -AllocationMethod Dynamic -DomainNameLabel $vmDNSname
$nic = New-AzureRmNetworkInterface -ResourceGroupName $rgname -Name "nic1" -Subnet $subnet -Location $region -PublicIpAddress $pip -PrivateIpAddress "10.0.64.4"

# Create VM
$publisher = "MicrosoftWindowsServer"
$offer = "WindowsServer"
$sku = "2012-R2-Datacenter"
$version = "latest"
$cred = Get-Credential

$vmConfig = New-AzureRmVMConfig -VMName $vmDNSname -VMSize "Standard_A1"
Set-AzureRmVMOperatingSystem -VM $vmconfig -Windows -ComputerName "contoso-w1" -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
$vmConfig | Set-AzureRmVMSourceImage -PublisherName $publisher -Offer $offer -Skus $sku -Version $version
$vmConfig | Set-AzureRmVMOSDisk -Name "$vmDNSname-w1" -VhdUri "https://$storagename.blob.core.windows.net/vhds/$vmDNSname-w1-os.vhd" -Caching ReadWrite -CreateOption fromImage
$vmConfig | Add-AzureRmVMNetworkInterface -Id $nic.Id
New-AzureRmVM -ResourceGroupName $rgname -Location $region -VM $vmConfig
