Configuration DataDisk
{
       Import-DscResource -ModuleName PSDesiredStateConfiguration
       Import-DSCResource -ModuleName xStorage

        Node localhost
        {
            xWaitforDisk Disk
            {
                DiskNumber = 1
            }

            xDisk DataVolume
            {
                DiskNumber = 1
                DriveLetter = 'F'
                DependsOn = '[xWaitforDisk]Disk'
            }

        }
}
