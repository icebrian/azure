Login-AzureRmAccount

#Get-AzureRmSubscription

Select-AzureRmSubscription -SubscriptionId fb8f8229-3cbd-4811-843c-ce7344396f8a

Get-AzureRmResourceGroup -Name demo1

Get-AzureRmVM -Name icwindemo001 -ResourceGroupName demo1

Get-AzureRmVMUsage -Location "West Europe" -Verbose