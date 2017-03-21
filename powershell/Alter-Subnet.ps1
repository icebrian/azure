

Login-AzureRmAccount
#Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a


# Obtain VM reference and check Availability Set #

$RGname = "emdb-ase-winvm"
$VMName = “emdb-ase-winvm”

$VirtualMachine = Get-AzureRmVM -ResourceGroupName $RGname -Name $VMName

# VM created in Availability Set

$VirtualMachine.AvailabilitySetReference

# Obtain NIC, subnet and VNET references: #

$NICname = "emdb-ase-winvm548"

$NIC = Get-AzureRmNetworkInterface -Name $NICname -ResourceGroupName $RGname
$NIC.IpConfigurations[0].PrivateIpAddress # ‘10.1.1.4’

#--------------

$VNETname = "emdb-ase-vnet"
$RGname = "emdb-ase"

$VNET = Get-AzureRmVirtualNetwork -Name $VNETname  -ResourceGroupName $RGname

$Subnet2name = "default"
Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNET -Name $Subnet2name

$Subnet2name = "secondary"
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VNET -Name $Subnet2name -AddressPrefix 192.168.251.0/26

