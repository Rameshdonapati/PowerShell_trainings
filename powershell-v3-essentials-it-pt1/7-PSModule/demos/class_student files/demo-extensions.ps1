#requires -version 3.0

#demo snapins and modules

<# 

1. What is Powershell Module ?

Time: 2mins

#>

#region PSSnapins
get-command -Noun PSSnapin

#show currently installed snapins
Get-PSSnapin

#-module is an alias for -pssnapin
get-command -Module *core | more

#read more
help about_PSSnapins 
cls

#endregion

#region Modules

get-command -noun Module

#what is loaded?
Get-Module

#PowerShell searches these paths
$env:PSModulePath

#list system modules
dir $pshome\modules

#what is available?
Get-Module -ListAvailable

#getting commands
gcm -mod psscheduledjob

Import-Module PSWorkflow
gmo #additional psworkflow module is loaded

#remove it
remove-module PSWorkflow
gmo

#autoload
help Get-SmbShare
gmo # smbshare module gets autoload

#read more
help about_modules

cls
#endregion
