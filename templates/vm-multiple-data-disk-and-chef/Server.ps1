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

            xWaitforDisk Disk2
            {
                DiskNumber = 1
            }

            xDisk Volume2
            {
                DiskNumber = 1
                DriveLetter = 'G'
                DependsOn = '[xWaitforDisk]Disk2'
            }

            xWaitforDisk Disk3
            {
                DiskNumber = 2
            }

            xDisk Volume3
            {
                DiskNumber = 2
                DriveLetter = 'H'
                DependsOn = '[xWaitforDisk]Disk3'
            }

            xWaitforDisk Disk4
            {
                DiskNumber = 3
            }

            xDisk Volume4
            {
                DiskNumber = 3
                DriveLetter = 'I'
                DependsOn = '[xWaitforDisk]Disk4'
            }
        }
}
