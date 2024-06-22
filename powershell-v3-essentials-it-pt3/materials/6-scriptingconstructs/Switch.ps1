write-host "Please select options from below" -ForegroundColor Green
write-host ""
write-host "1. run sales server configuration" -ForegroundColor Green
write-host "2. run IT server configuration" -ForegroundColor Green
write-host "3. run Acc server configuration" -ForegroundColor Green
write-host "4. run exe server configuration" -ForegroundColor Green
write-host "5. exit" -ForegroundColor Green

$int = read-host "please provide your input"



Switch ($int) {
    1 {
      Write-Host "Running Sales department configuration" -ForegroundColor Cyan
     }
    2 {
      Write-Host "Running IT department configuration" -ForegroundColor Cyan
     }
    3 {
      Write-Host "Running Accounting department configuration" -ForegroundColor Cyan
     }
   4 {
      Write-Host "Running Executive department configuration" -ForegroundColor Cyan
     }
    Default {
      Write-Host "exit script" -ForegroundColor Cyan
     }
     }