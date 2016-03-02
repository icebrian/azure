
##
## XPlat-CLI
##

# List Extension publishers
azure vm extension list-image-publishers --location "West Europe"

# List extensions in West Europe for PuppetLabs
azure vm extension list-image-types --location "West Europe" --publisher "PuppetLabs"
azure vm extension list-image-types --location "West Europe" --publisher "Microsoft.WindowsAzure.Compute"
azure vm extension list-image-types --location "West Europe" --publisher "Microsoft.Azure.Extensions"

# Get extension in VM
azure vm extension get --resource-group "cm-arm" --vm-name "w2k12r2-cmarm01"

# Set/Add Puppet Agent extension to VM
azure vm extension set --resource-group "cm-arm" --vm-name "w2k12r2-cmarm01" --name "PuppetEnterpriseAgent" --publisher-name "PuppetLabs" --version "3.8.4"




























##
## Power Shell
##
## More Info.: http://go.microsoft.com/fwlink/?linkid=394789&clcid=0x409

Login-AzureRmAccount

Get-AzureRmVM -ResourceGroupName "cm-arm"

$Settings = @{"fileUris" = "[]"; "commandToExecute" = ""};
$ProtectedSettings = @{"storageAccountName" = $stoname; "storageAccountKey" = $stokey};
Set-AzureRmVMExtension -ResourceGroupName "ResourceGroup11" -Location "West US" -VMName "VirtualMachine22" -Name "ContosoTest" -Publisher "Contoso.Compute" -Type "CustomScriptExtension" -TypeHandlerVersion "1.1" -Settings $Settings -ProtectedSettings $ProtectedSettings;
