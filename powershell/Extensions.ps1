
#http://go.microsoft.com/fwlink/?linkid=394789&clcid=0x409

#Login-AzureRmAccount

#Get-AzureRmVM -ResourceGroupName "iscebria"

Set-AzureRmVMAccessExtension -Name "Win2K12-R2-DC2" -ResourceGroupName "iscebria" -VMName "Win2K12-R2-DC2"

Get-AzureRmVMExtension -Name "Win2K12-R2-DC2" -ResourceGroupName "iscebria" -VMName "Win2K12-R2-DC2"