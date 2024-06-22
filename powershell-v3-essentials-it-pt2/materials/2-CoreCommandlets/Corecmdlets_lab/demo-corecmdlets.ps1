#requires -version 3.0

#demo Core cmdlets

#region Get-Childitem

help dir -showwindow

dir D:\Trainings\Adv_Azure_Powershell
dir D:\Trainings\Adv_Azure_Powershell -recurse

#filtering techniques
$a = { dir D:\Trainings\Adv_Azure_Powershell\*.ps1 -recurse}
&$a
$b = {dir D:\Trainings\Adv_Azure_Powershell -include *.ps1 -recurse}
&$b
$c = {dir D:\Trainings\Adv_Azure_Powershell -filter *.ps1 -recurse}
&$c

measure-command $a 
measure-command $b 
measure-command $c 


#getting items by attribute
dir D:\Trainings\Adv_Azure_Powershell -Directory
dir D:\Trainings\Adv_Azure_Powershell\Archieve -file

dir c:\ -Hidden
dir c:\ -Hidden -File
#endregion

#region Where-Object

#legacy syntax
get-service | where {$_.status -eq 'Stopped'}

#new syntax
get-service | where status -eq 'Stopped'

dir D:\Trainings\Adv_Azure_Powershell -file | where Length -ge 100kb

dir D:\Trainings | 
where LastWritetime -lt (Get-Date).AddDays(-90)

#but something more complex will fail
dir D:\Trainings | 
where LastWritetime -gt (Get-Date).AddDays(-90) -AND Length -gt 15KB

#need to use older syntax
dir D:\Trainings| 
where { ($_.LastWritetime -lt (Get-Date).AddDays(-90)) -AND ($_.length -gt 15KB)}

#always filter early when possible
#both commands will work but one is 'better' than the other
Measure-Command {
 dir D:\Trainings\Adv_Azure_Powershell -recurse | where {$_.extension -eq '.ps1'}
}

Measure-Command {
 dir D:\Trainings\Adv_Azure_Powershell -recurse -filter '*.ps1'
}
#endregion

#region Sort-Object

get-process  | Sort cpu # default is ascending
get-process | Sort cpu -Descending


#endregion

#region Select-Object

#objects
get-process | 
Sort cpu -Descending | Select -First 5

get-process | 
Sort cpu -Descending | Select -last 5

#properties
dir D:\Trainings\Adv_Azure_Powershell -file | Select Name,Length,LastWriteTime
dir D:\Trainings\Adv_Azure_Powershell -file | get-member

#create customproperties
$data = dir D:\Trainings\Adv_Azure_Powershell -file | 
Select Name,@{Name="Size";Expression={$_.Length}},
LastWriteTime,@{Name="Age";Expression={
((Get-Date) - $_.lastWriteTime).Days}} |
Sort Size -Descending 

#selecting is not the same as formatting
$data



#select unique objects
1,4,5,1,6,6,7,8 | select -Unique
Get-Process  | select -Unique

Get-Process | select handles,sessionid 

#expand properties
#this is hard to read because the property is a collection of objects
get-service winmgmt | Select DependentServices
#so expand it
get-service winmgmt | 
Select -expandproperty DependentServices

#endregion

#region Group-Object

$logs = Get-eventlog system -newest 100 | Group Source
$logs

#this is a different object
$logs | sort Count -Descending
$logs | gm

#get grouped objects
$logs[0].group
$logs[0].group | Select EntryType,Message

#create without the elements
Get-eventlog system -newest 100 |
Group EntryType -NoElement | Sort Count

#or create a hashtable
$groupHash = Get-eventlog system -newest 100  |
Group EntryType -AsHashTable -AsString

#forced PowerShell to treat EntryType as a string, because
#it is technically [system.diagnostics.eventlogentrytype]

$groupHash
$grouphash.error


#endregion

#region Measure-Object

get-process | measure

get-process  |  measure cpu,handles -sum -Minimum -Maximum -Average

dir D:\Trainings\Adv_Azure_Powershell -Directory | 
Select FullName,LastWriteTime,@{Name="Size";Expression={ 
 $stats = dir $_.Fullname -recurse | Measure-Object Length -sum
 $stats.sum
}} |fl

#endregion

#region Get-Content

get-content D:\Trainings\servers_status_log.txt

#get the head (alias parameter)
get-content D:\Trainings\servers_status_log.txt -head 5

#get the tail of a file
get-content D:\Trainings\servers_status_log.txt -Tail 5

#get tail and watch
get-content D:\Trainings\servers_status_log.txt -Tail 1 -Wait

#endregion

#region Putting it all together

#using aliases for this one line command

https://technet.microsoft.com/en-us/virtuallabs

$data = get-wmiobject win32_OperatingSystem -ComputerName (cat D:\Trainings\servers.txt | where {$_}) | 
Select Caption,@{Name="Computername";Expression={$_.CSName}},
@{Name="FreePhysMemBytes";Expression={$_.FreePhysicalMemory*1kb}},
@{Name="TotalPhysMemBytes";Expression={$_.TotalVisibleMemorySize*1kb}},
@{Name="PercentFreeMem";Expression={
($_.FreePhysicalMemory/$_.TotalVisibleMemorySize)*100}},
NumberofUsers,NumberofProcesses |
Group Computername -AsHashTable -AsString

$data

#need to handle the dash
$data.'chi-dc03'

#analyze the data
$data.GetEnumerator() | select -expand Value | 
Where {$_.percentFreeMem -le 25} |
sort PercentFreeMem -Desc | 
select Comp*,P*,Num*

#I used abbreviations and shortcuts to simulate how you would type it
#interactively. In a script don't use the shortcuts.

#endregion


