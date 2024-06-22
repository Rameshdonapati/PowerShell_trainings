#requires -version 3.0

#demo hashtables
#what is an hash table ?

#creating
$e = @{Name="Rams";Title="Azure";Computer=$env:COMPUTERNAME}
$e

#this is its own object
$e | gm



#enumerating key
$e.keys

#referencing elements
$e.Item("computer")
$e.computer

#creating an empty hash
$f=@{}

#adding to it
$f.Add("Name","Rams")
$f.Add("Company","Onlinebims")
$f.Add("Office","Bangalore")
$f

#changing an item
$f.Office
$f.Office = "Hyderabad"
$f

#keys must be unique
$f.add("Name","Jane")
$f.ContainsKey("name")

#removing an item
$f.Remove("name")
$f


#group-object can create a hash table
$source = get-eventlog system -newest 100 | 
group Source -AsHashTable
$source

#get a specific entry
$source.EventLog

#handle names with spaces
$source.'Service Control Manager'[0]

#this value is an array of event log objects
$source.EventLog[0..3]
$source.EventLog[0].message

#using GetEnumerator()
$source | get-member
$source.GetEnumerator() | Get-Member
$source

#this will fail
$source | sort Name | Select -first 5
#here's the correct approach
$source.GetEnumerator() | Sort name | select -first 5

#Or another thing you might want to try. This will fail
$source | where {$_.name -match "dcom"}

#although,you could do this:
$source.Keys | where {$_ -match "dcom"} | 
foreach { $source.Item($_)}

#but this is a little easier and slightly faster
$source.GetEnumerator() | where {$_.name -match "dcom"} | 
Select -expand Value

#hash tables are unordered
$hash = @{
Name="rams"
Company="onlinebims"
Office="Hyderabad"
Computer=$env:computername
OS = (get-ciminstance win32_operatingsystem -Property Caption).caption
}

$hash

#ordered 
$hash = [ordered]@{
Name="Jeff"
Company="Globomantics"
Office="Chicago"
Computer=$env:computername
OS = (get-ciminstance win32_operatingsystem -Property Caption).caption
}

$hash

#hashtables as object properties
$os = Get-CimInstance win32_Operatingsystem
$cs = Get-CimInstance win32_computersystem

$properties = [ordered]@{
Computername = $os.CSName
MemoryMB = $cs.TotalPhysicalMemory/1mb -As [int]
LastBoot = $os.LastBootUpTime
}

New-Object -TypeName PSObject -Property $properties

#hashtables as custom objects
[pscustomobject]$properties

#a larger example
#assume computers all running PowerShell 3.0
$computer = $env:computername
$data = { 
    #simplified without any real error handling
    $os = Get-CimInstance win32_Operatingsystem 
    $cs = Get-CimInstance win32_computersystem
    $cdrive = Get-CimInstance win32_logicaldisk -filter "deviceid='c:'" 
    
    [pscustomobject][ordered] @{
    Computername = $os.CSName
    OperatingSystem = $os.Caption
    Arch = $os.OSArchitecture
    MemoryMB = $cs.TotalPhysicalMemory/1mb -As [int]
    PercentFreeC = ($cdrive.freespace/$cdrive.Size)*100 -as [int]
    LastBoot = $os.LastBootUpTime
    Runtime = (get-Date) - $os.LastBootUpTime
   }

   }
&$data 

#or analyze the data
&$data | sort runtime | select computername,runtime

#region for bringing remote data 
$servers = "server1","server2","server3"
$data = @()
foreach($server in $servers){
 { 
    #simplified without any real error handling
    $os = Get-CimInstance win32_Operatingsystem -ComputerName $server
    $cs = Get-CimInstance win32_computersystem -ComputerName $server
    $cdrive = Get-CimInstance win32_logicaldisk -filter "deviceid='c:'" -ComputerName $server
    
  $info=  [pscustomobject][ordered] @{
    Computername = $os.CSName
    OperatingSystem = $os.Caption
    Arch = $os.OSArchitecture
    MemoryMB = $cs.TotalPhysicalMemory/1mb -As [int]
    PercentFreeC = ($cdrive.freespace/$cdrive.Size)*100 -as [int]
    LastBoot = $os.LastBootUpTime
    Runtime = (get-Date) - $os.LastBootUpTime
   }
}
  $data += $info }
$data 
#endregion


