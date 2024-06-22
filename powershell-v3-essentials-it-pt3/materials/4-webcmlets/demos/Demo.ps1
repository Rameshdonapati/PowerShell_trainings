#requires -version 3.0

#>
#region for Invoke-WebRequest 
help Invoke-WebRequest -ShowWindow



$r = invoke-webrequest 'https://www.homestyler.com/int/'
$r
$r.StatusCode
$r.Headers

#endregion


#region Invoke-RestMethod

help Invoke-RestMethod -ShowWindow


$uri = 'https://blogs.msdn.microsoft.com/powershell/feed/'

$data = Invoke-RestMethod $uri
$data

$data | Select Title,Description,
@{Name="Published";Expression={$_.PubDate -as [datetime]}},Link |
format-list

#endregion



