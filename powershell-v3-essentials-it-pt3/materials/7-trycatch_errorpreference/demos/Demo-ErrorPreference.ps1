#requires -version 3.0

#region Using the ErrorActionPreference variable

$ErrorActionPreference

#define a scriptblock which has its own scope
$sb = {
write-host "begin" -ForegroundColor Green
write-host "ErrorActionPreference is $ErrorActionPreference" -ForegroundColor Yellow
gwmi win32_foo
write-host "end" -ForegroundColor Green
}

#invoke the scriptblock
&$sb

#check the most recent error
$Error.count
$error[0]
#this is a complex object
$error[0] | select *

#try different settings
cls
"SilentlyContinue","Ignore","Inquire","Stop" | foreach {
  $ErrorActionPreference = $_
  &$sb
  Write-host "ERROR: $($error[0].Exception)" -ForegroundColor Magenta
}

#reset
$ErrorActionPreference = "continue"

#endregion

#region using the ErrorAction parameter



