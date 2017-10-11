# IIS VMs and SQL VM

## Disclaimer
<b>This is a personal template based on templates provided at https://github.com/Azure/azure-quickstart-templates. These are for personal test use-cases and should not be used by anyone else!</b>

## Deploy
<a href="https://portal.azure.com/#create/Microsoft.Template/uri"/https%3A%2F%2Fraw.githubusercontent.com%2Ficebrian%2Fazure%2Fmaster%2Ftemplates%2Fiis-2vm-sql-1vm%2Fazuredeploy.json target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png" />
</a>
This template creates one or two Windows Server 2012R2 VM(s) with IIS configured using DSC. It also installs one SQL Server 2014 standard edition VM, a VNET with two subnets, NSG, loader balancer, NATing and probing rules.

## Resources
The following resources are created by this template:
- 1 or 2 Windows 2012R2 IIS Web Servers.
- 1 SQL Server 2014 running on premium or standard storage.
- 1 virtual network with 2 subnets with NSG rules.
- 1 storage account for the VHD files.
- 1 Availability Set for IIS servers.
- 1 Load balancer with NATing rules.


<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/iis-2vm-sql-1vm/images/resources.png" />


## Architecture Diagram
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/iis-2vm-sql-1vm/images/architecture.png" />

