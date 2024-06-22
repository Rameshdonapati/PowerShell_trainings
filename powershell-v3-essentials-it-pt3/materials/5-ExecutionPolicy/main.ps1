$global:x = 5


D:\Trainings\PS_Training\powershell-v3-essentials-it-pt3\materials\5-ExecutionPolicy\myscript.ps1



Invoke-Command -ComputerName $server -scripblock{

$y = $x * 3

$x =10 
$y

return
} 

$Y
