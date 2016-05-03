Configuration DataDisk
{
       Import-DscResource -ModuleName PSDesiredStateConfiguration
       Import-DSCResource -ModuleName xStorage

        Node localhost
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
