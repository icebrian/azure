$newVM = New-AzureVMConfig -Name "{new VM name}" -InstanceSize {Instance size} -ImageName {Image file name} -HostCaching ReadWrite -DiskLabel "OS" -MediaLocation "http://{Storage account URL}.blob.core.windows.net/vhds/{disk name}.vhd" |
 Add-AzureProvisioningConfig -WindowsDomain -AdminUsername "{admin user}" -Password "{password}" -Domain "{NetBIOS domain name}" -DomainUserName "{domain user}" -DomainPassword "{domain password}" -JoinDomain "{FQDN of domain}" |
 Set-AzureSubnet -SubnetNames "{Subnet name}"
 
New-AzureVM -VMs $newVm -ServiceName {Cloud service name}