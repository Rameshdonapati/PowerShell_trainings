#requires -version 3.0
#demonstrate PowerShell providers
#run in an elevated shell

#region Providers

Get-PSProvider
help about_providers 

#endregion

#region PSDrives

Get-Command -Noun PSdrive
help Get-PSDrive 
Get-PSDrive

help New-PSDrive 
New-PSDrive -Name Training -PSProvider FileSystem -Root D:\Trainings
New-PSDrive i FileSystem -Root \\server\Trainings 
get-psdrive 

cls
#endregion

#region FileSystem
cls

cd \
dir
help dir 

cd training:
dir | more
#lists just folders
dir -Directory
#list just files and recurse
dir -File -Recurse
#filtering is can by tricky
#this will work
dir *.txt 
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
dir .\system\CurrentControlSet\Services\aelookupsvc -recurse | more
#but sometimes you need to do this.
#this won't work
dir .\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
get-item .\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
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
#but I recommend this
$env:windir
$env:psmodulepath

help environment

cls
#endregion

#region Certificate
cd cert:
dir currentuser
cd LocalMachine
dir CA 
#these are objects
#We haven't covered this yet, but trust me
dir CA  | Select Subject,FriendlyName,Not*,Archived,thumbprint

dir ca | gm

#read more
Help Certificate

cls
#endregion







$env:COMPUTERNAME

New-PSDrive -Name Temp -PSProvider Environment -Root $env:temp

New-PSDrive -Name "temp" -PSProvider "%TEMP%" c:
get-itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name productname