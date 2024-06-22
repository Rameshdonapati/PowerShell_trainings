help Update-Help -showwindow
#update all help
update-help -force

#update for a specific module
get-module microsoft.powershell* -list | update-help -force

#save help
help save-help -showwindow
Save-Help -destination D:\Trainings\help -force

#updating help from source
Update-help -source D:\Trainings\help -force

cls
