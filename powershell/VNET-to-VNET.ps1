#
# https://azure.microsoft.com/en-us/documentation/articles/vpn-gateway-vnet-vnet-rm-ps/
# https://ranjanajain.wordpress.com/2016/03/03/quick-n-easy-vnet-to-vnet-vpn-from-new-azure-portal-using-gui/
#

##Declare your variables for TestVNet1
$Sub1          = "fb8f8229-3cbd-4811-843c-ce7344396f8a"
$RG1           = "multinet"
$Location1     = "West Europe"

$VNetName1     = "multinet-Ext"
$FESubName1    = "FrontEnd"
$BESubName1    = "Backend"
$GWSubName1    = "GatewaySubnet"
$VNetPrefix11  = "10.11.0.0/16"
$VNetPrefix12  = "10.12.0.0/16"
$FESubPrefix1  = "10.11.0.0/24"
$BESubPrefix1  = "10.12.0.0/24"
$GWSubPrefix1  = "10.12.255.0/27" #Max /16 - min /29

$DNS1          = "8.8.8.8"
$GWName1       = "VNet1GW"
$GWIPName1     = "VNet1GWIP"
$GWIPconfName1 = "gwipconf1"
$Connection14  = "VNet1toVNet4"
$Connection15  = "VNet1toVNet5"

##Login
#Login-AzureRmAccount
#Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId $Sub1

#Create a new resource group
New-AzureRmResourceGroup -Name $RG1 -Location $Location1

#Create the subnet configurations for TestVNet1
$fesub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $FESubName1 -AddressPrefix $FESubPrefix1
$besub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $BESubName1 -AddressPrefix $BESubPrefix1
$gwsub1 = New-AzureRmVirtualNetworkSubnetConfig -Name $GWSubName1 -AddressPrefix $GWSubPrefix1

#Create TestVNet1
New-AzureRmVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1 -Location $Location1 -AddressPrefix $VNetPrefix11,$VNetPrefix12 -Subnet $fesub1,$besub1,$gwsub1

#Request a public IP address
$gwpip1    = New-AzureRmPublicIpAddress -Name $GWIPName1 -ResourceGroupName $RG1 -Location $Location1 -AllocationMethod Dynamic

#Create the gateway configuration
$vnet1     = Get-AzureRmVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1
$subnet1   = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet1
$gwipconf1 = New-AzureRmVirtualNetworkGatewayIpConfig -Name $GWIPconfName1 -Subnet $subnet1 -PublicIpAddress $gwpip1

#Create the gateway for TestVNet1
New-AzureRmVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1 -Location $Location1 -IpConfigurations $gwipconf1 -GatewayType Vpn -VpnType RouteBased -GatewaySku Standard

##Declare your variables for TestVNet4
$RG4           = "multinet"
$Location4     = "West Europe"
$VnetName4     = "TestVNet4"
$FESubName4    = "FrontEnd"
$BESubName4    = "Backend"
$GWSubName4    = "GatewaySubnet"
$VnetPrefix41  = "10.41.0.0/16"
$VnetPrefix42  = "10.42.0.0/16"
$FESubPrefix4  = "10.41.0.0/24"
$BESubPrefix4  = "10.42.0.0/24"
$GWSubPrefix4  = "10.42.255.0/27"
$DNS4          = "8.8.8.8"
$GWName4       = "VNet4GW"
$GWIPName4     = "VNet4GWIP"
$GWIPconfName4 = "gwipconf4"
$Connection41  = "VNet4toVNet1"

#Create a new resource group
#New-AzureRmResourceGroup -Name $RG4 -Location $Location4

#Create the subnet configurations for TestVNet4
$fesub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $FESubName4 -AddressPrefix $FESubPrefix4
$besub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $BESubName4 -AddressPrefix $BESubPrefix4
$gwsub4 = New-AzureRmVirtualNetworkSubnetConfig -Name $GWSubName4 -AddressPrefix $GWSubPrefix4

#Create TestVNet4
New-AzureRmVirtualNetwork -Name $VnetName4 -ResourceGroupName $RG4 -Location $Location4 -AddressPrefix $VnetPrefix41,$VnetPrefix42 -Subnet $fesub4,$besub4,$gwsub4

#Request a public IP address
$gwpip4    = New-AzureRmPublicIpAddress -Name $GWIPName4 -ResourceGroupName $RG4 -Location $Location4 -AllocationMethod Dynamic

#Create the gateway configuration
$vnet4     = Get-AzureRmVirtualNetwork -Name $VnetName4 -ResourceGroupName $RG4
$subnet4   = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet4
$gwipconf4 = New-AzureRmVirtualNetworkGatewayIpConfig -Name $GWIPconfName4 -Subnet $subnet4 -PublicIpAddress $gwpip4

#Create the TestVNet4 gateway
New-AzureRmVirtualNetworkGateway -Name $GWName4 -ResourceGroupName $RG4 -Location $Location4 -IpConfigurations $gwipconf4 -GatewayType Vpn -VpnType RouteBased -GatewaySku Standard

#Connecting the gateways

#Get both virtual network gateways
$vnet1gw = Get-AzureRmVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1
$vnet4gw = Get-AzureRmVirtualNetworkGateway -Name $GWName4 -ResourceGroupName $RG4

#Create the TestVNet1 to TestVNet4 connection
New-AzureRmVirtualNetworkGatewayConnection -Name $Connection14 -ResourceGroupName $RG1 -VirtualNetworkGateway1 $vnet1gw -VirtualNetworkGateway2 $vnet4gw -Location $Location1 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'

#Create the TestVNet4 to TestVNet1 connection
New-AzureRmVirtualNetworkGatewayConnection -Name $Connection41 -ResourceGroupName $RG4 -VirtualNetworkGateway1 $vnet4gw -VirtualNetworkGateway2 $vnet1gw -Location $Location4 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'
