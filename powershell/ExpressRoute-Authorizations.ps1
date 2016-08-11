# https://azure.microsoft.com/en-us/documentation/articles/expressroute-howto-circuit-portal-resource-manager/
# https://azure.microsoft.com/en-us/documentation/articles/expressroute-howto-linkvnet-portal-resource-manager/
# https://azure.microsoft.com/en-us/documentation/articles/expressroute-howto-linkvnet-arm/

Login-AzureRmAccount

Get-AzureRmSubscription

#BdP
#Select-AzureRmSubscription -SubscriptionId 0c2fde05-b8d7-43fd-826a-7eb73680911a

# Reviewing authorizations
$circuit = Get-AzureRmExpressRouteCircuit -Name "INTERNET.AZ.COLT" -ResourceGroupName "INTERNET.AZ.RG_NETWORKING"
$authorizations = Get-AzureRmExpressRouteCircuitAuthorization -ExpressRouteCircuit $circuit

