
$source_path = "C:\source\path"

$destination_path = "\\192.71.31.90\c$\Storage\Vol\Data"

robocopy $source_path $destination_path /MIR /MT:128 /FFT /Z /E /W:5 /R:10 /TEE /LOG:C:\temp\RoboCopyLog-new2.txt