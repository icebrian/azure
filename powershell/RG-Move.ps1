
Login-AzureRmAccount
Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId 6373b93d-5576-42bb-88b4-a9297a49cf4f

#Get-AzureRmResourceGroup -ResourceGroupName "rg-consolidatednew"
#Get-AzureRmResource | ? ResourceGroupName -EQ lrg-consolidatednew

$webapp = Get-AzureRmResource -ResourceGroupName "rg-consolidatednew" -ResourceName "appinsightsic001"
Move-AzureRmResource -DestinationSubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a -DestinationResourceGroupName NewRG -ResourceId $webapp.ResourceId

#$webapp = Get-AzureRmResource -ResourceGroupName "rg-consolidatednew" -ResourceName "appinsightsic001"
#$plan = Get-AzureRmResource -ResourceGroupName OldRG -ResourceName ExamplePlan
#Move-AzureRmResource -DestinationSubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a -DestinationResourceGroupName NewRG -ResourceId $webapp.ResourceId, $plan.ResourceId -WhatIf