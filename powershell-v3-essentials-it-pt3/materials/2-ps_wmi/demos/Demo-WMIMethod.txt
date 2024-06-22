#requires -version 3.0

#demo Invoke-WMIMethod

notepad
#you can use methods directly
$notepad = Get-WmiObject win32_process -filter "name='notepad.exe'"

$notepad | gm -MemberType method

#need () even if no methods
#no -Whatif
$notepad.Terminate()

#return value of 0 means success
help Invoke-WmiMethod -ShowWindow

notepad

Get-WmiObject win32_process -filter "name='notepad.exe'" |
Invoke-WmiMethod -Name Terminate -WhatIf

Get-WmiObject win32_process -filter "name='notepad.exe'" |
Invoke-WmiMethod -Name Terminate

