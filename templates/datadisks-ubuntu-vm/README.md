# Create Ubuntu vm multiple data disks

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ficebrian%2Fazure%2Fmaster%2Ftemplates%2Fdatadisks-ubuntu-vm%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This is a simple template that deploys an Ubuntu Virtual Machine with 3 data disks attached. It then mounts wach data disk in specified mount points.

This template also deploys a Storage Account, Virtual Network, Public IP addresses, and a Network Interface.

Note: Mount point should not include trailing backslash. It is assumed mount point will always reside in root!
