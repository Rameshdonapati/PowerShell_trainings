

Add-Type -AssemblyName presentationframework, presentationcore
$wpf = @{ }
$inputXML = Get-Content -Path "D:\Trainings\PS_Training\UI\MainWindow.xaml"
$inputXMLClean = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace 'x:Class=".*?"','' -replace 'd:DesignHeight="\d*?"','' -replace 'd:DesignWidth="\d*?"',''
[xml]$xaml = $inputXMLClean
$reader = New-Object System.Xml.XmlNodeReader $xaml
$tempform = [Windows.Markup.XamlReader]::Load($reader)
$namedNodes = $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")
$namedNodes | ForEach-Object {$wpf.Add($_.Name, $tempform.FindName($_.Name))}


#========================================================



#========================================================
#Your Code goes here
#========================================================


#This code runs when the button is clicked
$wpf.submit.add_Click({

        #Get screen name from textbox
        $servers = $wpf.serverslist.text

        foreach($server in $servers){
        $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter "DeviceID='C:'" |
        Select-Object Size,FreeSpace

        #Show data output in GUI
		$wpf.output.source = $disk
            }
	})

#=======================================================
#End of Your Code
#=======================================================



$wpf.diskspace.ShowDialog() | Out-Null