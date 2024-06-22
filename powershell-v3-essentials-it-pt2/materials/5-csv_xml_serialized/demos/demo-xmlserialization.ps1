#requires -version 3.0

#demo XML serialization
#run these commands in the ISE

#region Clixml
$path= 'D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\5-csv_xml_serialized\procs.xml'
Get-Process | Export-Clixml $path

psedit $path

$p = Import-Clixml $path
$p | gm

#imported objects can be used almost like any other
#process object
$p
$p | sort ws -desc | select -first 5

#endregion

#region Convert XML

$xml = get-process | ConvertTo-Xml
$xml | gm
$xml
$xml.Objects
#xml objects are a bit more complicated to work with
$xml.objects.Object

#save the file. Recommend using full path
$xml.Save("$path")

#but this is a different type of xml file
psedit $path

#and it can't be imported using Import-clixml
Import-Clixml $path

#if you want to work with the object in PowerShell
[xml]$myprocs = Get-Content $path

$myprocs

#endregion