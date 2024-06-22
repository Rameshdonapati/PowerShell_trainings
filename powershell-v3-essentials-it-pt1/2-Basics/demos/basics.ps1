

#don't expect to understand everything I'm going to show

#cmdlets
get-command -CommandType cmdlet -ListImported | more

get-command -verb export
get-command -noun ACL

#a cmdlet in action
Get-Service

#aliases
dir D:\Trainings
ls D:\Trainings
get-alias D:\Trainings

#help will be covered in more detail in another lesson
help dir

#customize behavior
dir D:\Trainings\*.ps1 -file -recurse

#because we have objects we can do interesting things
dir D:\Trainings -file -recurse | where extension | group extension | Select Name,Count,@Name="Size";{Expression={($_.group | measure length -sum).sum} }| Sort Size -Descending | format-table -AutoSize

#read more about it
help *3.0

cls

