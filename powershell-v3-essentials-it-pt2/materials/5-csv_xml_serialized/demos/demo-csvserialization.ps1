#requires -version 3.0

#demo CSV serialization.
#these commands are designed for the ISE

#region Export-CSV

#region be careful what you export
$path= 'D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\5-csv_xml_serialized\msvc.csv'
get-service m* -ComputerName $env:computername | 
Export-Csv -Path $path

psedit $path
#endregion

#region select the properties you want
get-service m* -ComputerName $env:computername | 
Select Name,Displayname,Status,Machinename |
Export-Csv -Path $path

psedit $path
#endregion

#region no type information
get-service | Select name,displayname,status |
Export-csv $path -NoTypeInformation -Delimiter ";"

psedit $path
#endregion



#endregion

#region Import-CSV

#region default delimiter is comma
$impSvc = Import-Csv $path
$impSvc
$impSvc | gm
#endregion

#region works with any CSV
$s = import-csv $path -Delimiter ";"
$s
$s | gm

cd 'D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\5-csv_xml_serialized\demos'
psedit .\newusers.csv

#import and filter out blank lines
$n = import-csv .\newusers.csv| where {$_.OU}
$n

#endregion

#region Convert CSV

help convertto-csv -online

$a = get-service | select name,displayname,status | Convertto-CSV 
$a[0..4]

$b = $a | convertFrom-csv

#endregion

