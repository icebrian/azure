Configuration DataDisk
{
       Import-DSCResource -ModuleName xStorage

        Node localhost
        {
            xWaitforDisk Disk
            {
                DiskNumber = 2
            }

            xDisk DataVolume
            {
                DiskNumber = 2
                DriveLetter = 'F'
                DependsOn = '[xWaitforDisk]Disk'
            }

        }
}
