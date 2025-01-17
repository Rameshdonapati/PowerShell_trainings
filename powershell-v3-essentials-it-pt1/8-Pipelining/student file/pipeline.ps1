﻿#demo PowerShell Pipeline

#region Pipelining

get-service -name s* 
get-service -name s* | where {$_.status -eq 'running'} 
get-service -name s* | where {$_.status -eq 'running'} |Restart-Service -whatif

#using variables
$p = Get-Process
#this is the same thing as running Get-Process at the previous point in time
$p

$p | GM

$p | where {$_.workingset -gt 20mb}
#objects can change in the pipeline
$p | where {$_.workingset -gt 20mb} | measure-object Workingset -sum -Average

#passthru
notepad;notepad
get-process notepad 
get-process notepad | stop-process | Tee-Object -Variable killed
$killed

#look at help and see -Passthru
help stop-process

#let's repeat
notepad;notepad
get-process notepad | stop-process -PassThru | Tee-Object -Variable killed

$killed

cls
#endregion



#region Write-Host vs Write-Output

#these are all equivalent
write-output Jeff
write Jeff
#need quotes here to PowerShell knows this is a string
"Jeff"
#But this is hard to tell apart
Write-Host "Jeff"
#but it is not written to the pipeline
write "Jeff" | Get-Member
Write-Host "Jeff" | Get-Member

#when using Write-Host use a color
Write-Host "I am logged on as $env:userdomain\$env:username" -BackgroundColor Blue -ForegroundColor red

#you generally don't need to explicitly call Write-Output

#sidebar on variable expansion
$n = "Jeff"
"I am $n"
'I am $n'
"The value of `$n is $n"
"I am $n on computer $env:computername."
#this is where it gets tricky
$s = get-service bits
$s.DisplayName
$s.Status
"The $s.Displayname is $s.status"
#need a subexpression
"The $($s.Displayname) is $($s.status)."

cls
#endregion

#region ForEach-Object

#sometimes you need to do something to an object on an individual basis
notepad;notepad;notepad
get-process notepad
#the process object has a CloseMainWindow() method but you can only run 
#it one at a time
get-process notepad | foreach { 
 Write-Host "Closing process $($_.id)" -fore Yellow
 $_.CloseMainWindow()
 }

#this is ForEach-Object
$path = dir D:\Trainings\PS_Training\ -Directory | foreach {
  $stats = dir $_.fullName -Recurse -File | 
   Measure-Object length -sum
  $_ | Select-Object Fullname,
  @{Name="Size";Expression={$stats.sum}},
  @{Name="Files";Expression={$stats.count}}
} | Sort Size 

$path 
cls
#endregion


#region stream redirection

#simple redirection
get-process s* > D:\procs.txt
get-content D:\procs.txt

>
>>


#or append
get-process w* | out-file D:\procs.txt -Append
cat procs.txt


