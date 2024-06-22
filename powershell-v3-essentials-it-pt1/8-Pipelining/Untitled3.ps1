#Process Applicationframehost is using id 7636

$servers = "server1","server2","server3"

foreach($server in $servers){

write-host "Connecting $server ..." -ForegroundColor Green
}



$students  = "nawaz","Mahynder","ramesh","velukonda"

foreach($student in $students){

Write-host "$student is attending class from 10am to 12am " -ForegroundColor Cyan
}

Write-host "nawaz is attending class from 10am to 12am " -ForegroundColor Cyan
Write-host "mahynder is attending class from 10am to 12am " -ForegroundColor Cyan
Write-host "ramesh is attending class from 10am to 12am " -ForegroundColor Cyan
Write-host "velukonda is attending class from 10am to 12am " -ForegroundColor Cyan