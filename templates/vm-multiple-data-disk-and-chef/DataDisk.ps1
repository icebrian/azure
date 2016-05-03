Configuration Server
{
       Import-DscResource -ModuleName PSDesiredStateConfiguration
       Import-DSCResource -ModuleName xStorage

        Node DataDisk
        {
            xWaitforDisk Disk
            {
                DiskNumber = 0
            }

            xDisk Volume
            {
                DiskNumber = 0
                DriveLetter = 'F'
                DependsOn = '[xWaitforDisk]Disk'
            }
        }
}
