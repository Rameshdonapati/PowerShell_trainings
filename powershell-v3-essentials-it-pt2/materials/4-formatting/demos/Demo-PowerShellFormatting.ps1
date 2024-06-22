#requires -version 3.0

#demo PowerShell Formatting

#region Format-Wide

get-process | format-wide
get-process | format-wide -column 4
get-process | format-wide -AutoSize

#sort on property before grouping
gsv | Sort Status | fw -GroupBy status

gsv | Sort Status,displayname | 
fw -GroupBy status -Property Displayname

#endregion

#region Format-Table



# create a table
get-process | sort VM -Descending |
Select ID,Name,VM -first 10 |
Format-Table 

#it was already a table so let's autosize
get-process | sort VM -Descending |
Select ID,Name,VM -first 10 |
Format-Table -autosize
#endregion

#region Format-List

#great way to discover object properties
get-process system | format-list *

#some cmdlets might have a different view
get-process | ft
get-process | fl
dir D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\3-objects\objects
dir D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\3-objects\objects | fl


#or select properties
dir D:\Trainings\PS_Training\powershell-v3-essentials-it-pt2\materials\3-objects\objects | sort Extension |
fl -GroupBy Extension -prop Fullname,Length,CreationTime,LastWriteTime


#endregion
