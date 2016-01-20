$date = Get-Date

$directory = "C:\test_" + $date.Month + "-" + $date.Day + "_" + $date.Hour + "-" + $date.Minute

md $directory