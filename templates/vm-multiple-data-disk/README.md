# Create a Virtual Machine from a Windows Image with emtpy Data Disks and mount/prepare using DSC Resource

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ficebrian%2Fazure%2Fmaster%2Ftemplates%2Fvm-multiple-data-disk%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This template allows you to create a Windows Virtual Machine from a specified image during the template deployment. It also attaches empty data disks and mounts them (by initializing and formating) on specified paths.

Note: Uses https://github.com/PowerShell/xStorage

Very Important: "DiskNumber" in DataDisk.ps1 script needs to start with ID 2. ID 0 is for OS disk, whilst ID 1 is for TMP disk.