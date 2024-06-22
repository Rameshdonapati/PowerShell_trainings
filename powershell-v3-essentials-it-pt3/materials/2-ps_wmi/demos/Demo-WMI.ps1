#requires -version 3.0

#demo the WMI cmdlets

#region List WMI Classes

help get-wmiobject -ShowWindow

#list all classes that start with win32*
Get-WmiObject -List -class win32* | Out-GridView

#list all namespaces
gwmi -list -class "__namespace" -Namespace root -recurse |
Select @{Name="Namespace";Expression={$_.path.namespacepath}}

#endregion

#region Getting WMI information

#basic use

#-Class parameter is positional but I'll use it once
gwmi -class win32_operatingsystem

#this is just the default display. There are more properties
gwmi -class win32_operatingsystem | gm
gwmi -class win32_operatingsystem | select *

#you'll get an object for each class instance
gwmi win32_logicaldisk

#using query to limit results
gwmi -query "Select * from win32_logicaldisk where drivetype=3"
gwmi -query "Select * from win32_logicaldisk where deviceid='c:'"

#using filter
gwmi win32_logicaldisk -filter "drivetype=3"
gwmi win32_service -filter "startmode='auto' AND state<>'running'" |
Out-GridView



#region Query remote computers

$Computers = "chi-dc01","chi-dc02","chi-dc04","chi-fp02"

gwmi win32_operatingsystem -comp $computers

gwmi win32_operatingsystem -comp $computers | 
Select PSComputername,Caption,Version,
@{Name="ServicePack";Expression={$_.CSDVersion}},
InstallDate | Out-GridView

#or filter
gwmi win32_service -filter "startmode='auto' AND state<>'running'" -ComputerName $computers  |
Select PSComputername,Name,Displayname,Startmode,State,Startname,Description


#endregion

