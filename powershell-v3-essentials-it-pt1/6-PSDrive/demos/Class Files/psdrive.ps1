#requires -version 3.0
#demonstrate PowerShell providers
#run in an elevated shell

<#
1. What is PsProvider ?
2. What is PSDrive ?

Time 2mins
#>

#region Providers

Get-PSProvider

#endregion

#region PSDrives

Get-Command -Noun PSdrive
help Get-PSDrive 
Get-PSDrive

help New-PSDrive 
New-PSDrive -Name Training -PSProvider FileSystem -Root D:\Trainings

get-psdrive Training

cls
#endregion

#region FileSystem
cd \
dir

cd Training:
dir | more
#list just folders
dir -Directory
#list just files and recurse
dir -File -Recurse
#filtering is can by tricky
#this will work
dir .\*.txt 
dir -filter *.txt
#so will this if your recurse
dir -include *.txt -Recurse

help filesystem
cls
#endregion

#region Registry
get-psdrive -PSProvider Registry

cd hklm:

#some errors are to be expected
dir
dir .\system\CurrentControlSet\Services | more
dir .\system\CurrentControlSet\Services\ -recurse | more
#but sometimes you need to do this.

#or we can get item properties
Get-ItemProperty .\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

#list installed software packages
dir hklm:\software\microsoft\windows\Currentversion\Uninstall | more

#read more 
help registry

cls
#endregion

#region Environment
cd env:
dir

#this won't work
Get-ItemProperty .\windir
#some people will try get the value like this
Get-Item .\windir
(Get-Item windir).value
(Get-Item computername).value
#but I recommend this
$env:windir
$env:computername

help environment

cls
#endregion

#region Certificate
cd cert:
dir currentuser
cd LocalMachine
$data = dir CA 
#these are objects
#We haven't covered this yet, but trust me
dir CA  | Select Subject,FriendlyName,Not*,Archived

#read more
Help Certificate

cls
#endregion