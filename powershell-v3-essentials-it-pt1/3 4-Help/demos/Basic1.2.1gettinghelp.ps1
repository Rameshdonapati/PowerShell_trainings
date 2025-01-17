#demo using the Help system
help service

help get-service
help get-service -full
help get-service -examples

#help applies to aliases as well
help dir
help get-childitem

#look at about topics for content help
get-help about* | more

help about_if

#get online help
help invoke-command -online

#usually doesn't work for about files
help about_remote -online

#showwindow
help get-eventlog -showwindow
help about_switch -showwindow

#get help on get-help
get-help get-help | more

cls