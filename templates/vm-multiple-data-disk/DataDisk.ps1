Configuration DataDisk
{
       Import-DscResource -ModuleName PSDesiredStateConfiguration
       Import-DSCResource -ModuleName xStorage

        Node localhost
        {
            xWaitforDisk Disk2
            {
                DiskNumber = 2
            }

            xDisk DataVolume2
            {
                DiskNumber = 2
                DriveLetter = 'F'
                DependsOn = '[xWaitforDisk]Disk2'
            }

            xWaitforDisk Disk3
            {
                DiskNumber = 3
            }

            xDisk DataVolume3
            {
                DiskNumber = 3
                DriveLetter = 'G'
                DependsOn = '[xWaitforDisk]Disk3'
            }

            xWaitforDisk Disk4
            {
                DiskNumber = 4
            }

            xDisk DataVolume4
            {
                DiskNumber = 4
                DriveLetter = 'H'
                DependsOn = '[xWaitforDisk]Disk4'
            }

            xWaitforDisk Disk5
            {
                DiskNumber = 5
            }

            xDisk DataVolume5
            {
                DiskNumber = 5
                DriveLetter = 'I'
                DependsOn = '[xWaitforDisk]Disk5'
            }

        }
}
