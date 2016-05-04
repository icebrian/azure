Configuration DataDisk
{
       Import-DscResource -ModuleName PSDesiredStateConfiguration
       Import-DSCResource -ModuleName xStorage

        Node localhost
        {
            xDisk DataVolume
            {
                DiskNumber = 1
                DriveLetter = 'F'
            }
        }
}
