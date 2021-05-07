
<#
.SYNOPSIS
Script to manage Horizon Sessions by User
	
.NOTES
  Version:        1.1
  Author:         Chris Halstead - chalstead@vmware.com
  Creation Date:  5/7/2021
  Purpose/Change: Manage active sessions per user
  
  *Search for all sessions by username
    *Logoff All Sessions for user
    *Disconnect All Sessions for user
    *Send a Message to All Sessions for user
  
 #>

#----------------------------------------------------------[Declarations]----------------------------------------------------------
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$script:mydocs = [environment]::getfolderpath('mydocuments')
$script:date = Get-Date -Format d 
$script:date = $script:date -replace "/","_"
#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function LogintoHorizon {

#Capture Login Information

$script:HorizonServer = Read-Host -Prompt 'Enter the Horizon Server Name'
$Username = Read-Host -Prompt 'Enter the Username'
$Password = Read-Host -Prompt 'Enter the Password' -AsSecureString
$domain = read-host -Prompt 'Enter the Horizon Domain'

#Convert Password
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

try {
    
    $script:hvServer = Connect-HVServer -Server $horizonserver -User $username -Password $UnsecurePassword -Domain $domain -Force
    $script:hvServices = $hvServer.ExtensionData
    }

catch {
  Write-Host "An error occurred when logging on $_"
  break
}

write-host "Successfully Logged In"

} 

Function GetSessionsByUser {

  if ([string]::IsNullOrEmpty($hvServer))
  {
     write-host "You are not logged into Horizon"
      break   
       }

$sUserNameforSession = Read-Host -Prompt 'Enter the Username to Search Sessions For'

$query = New-Object "Vmware.Hv.QueryDefinition"

$qFilter = New-object VMware.Hv.QueryFilterEquals -property @{'memberName' ='base.name'; 'value' = $sUserNameforSession}

$query.Filter = $qFilter

$query.queryEntityType = 'ADUserOrGroupSummaryView'

$qSrv = New-Object "Vmware.Hv.QueryServiceService"

$sresult = $qSRv.QueryService_Query($hvServices,$query)

$qsrv.QueryService_Deleteall($hvservices)

if ($sresult.results.count -eq 0)
{
   write-host "No Sessions Found for " $sUserNameforSession
    break   
     }

$suserID = $sresult.Results[0].id.id

GetSessions($suserID)

}



Function GetSessions($suserID) {
    
    if ([string]::IsNullOrEmpty($hvServer))
    {
       write-host "You are not logged into Horizon"
        break   
       
    }
       
    try {

      $query = New-Object "Vmware.Hv.QueryDefinition"
      
      $qFilter = New-object VMware.Hv.QueryFilterEquals -property @{'memberName' ='referenceData.user'; 'value' = $sUserID}

      $query.Filter = $qFilter
      
      $query.queryEntityType = 'SessionLocalSummaryView'
      
      $qSrv = New-Object "Vmware.Hv.QueryServiceService"

      #Support over 1000 sessions
      $offset = 0
      $qdef = New-Object VMware.Hv.QueryDefinition
      $qdef.limit= 1000
      $qdef.maxpagesize = 1000
      $qdef.queryEntityType = 'SessionLocalSummaryView'

      $ssessionoutput=@()
      
      do{
        $qdef.startingoffset = $offset
        $sResult = $qsrv.queryservice_create($hvServices, $qdef)
            if (($sResult.results).count -eq 1000)
                {
                $maxresults = 1
                }
            else 
                {
                $maxresults = 0
                }

        $offset+=1000
        $ssessionoutput+=$sResult
        }
      until ($maxresults -eq 0)
      
      #Cleanup the query
      $qsrv.QueryService_Delete($hvServices, $sresult.id)
                     
    }
    
    catch {
      Write-Host "An error occurred when getting sessions $_"
     break 
    }
    
  if ($ssessionoutput.results.count -eq 0)
   {
    write-host "No Sessions for" $sUserNameforSession
    break   
    
    }

write-host "There are" $sresult.results.Count "total sessions for " $sUserNameforSession

#Write results to table
$ssessionoutput.Results | Format-table -AutoSize -Property @{Name = 'Session Start Time'; Expression = {$_.sessiondata.startTime}},@{Name = 'Display Protocol'; Expression = {$_.sessiondata.SessionProtocol}},@{Name = 'Username'; Expression = {$_.namesdata.username}},@{Name = 'Pool Name'; Expression = {$_.namesdata.desktopname}},@{Name = 'Machine Name'; Expression = {$_.namesdata.machineorrdsservername}}`
,@{Name = 'Client Name'; Expression = {$_.namesdata.clientname}},@{Name = 'Client Type'; Expression = {$_.namesdata.clienttype}},@{Name = 'Client Version'; Expression = {$_.namesdata.clientversion}},@{Name = 'Client IP'; Expression = {$_.namesdata.clientaddress}}`
,@{Name = 'Session Type'; Expression = {$_.sessiondata.sessiontype}},@{Name = 'Session State'; Expression = {$_.sessiondata.sessionstate}},@{Name = 'Location'; Expression = {$_.namesdata.securityGatewayLocation}},@{Name = 'Idle Duration'; Expression = {$_.sessiondata.IdleDuration}}

Write-Host "Press '1' to Logoff all sessions for"$sUserNameforSession
Write-Host "Press '2' to Disconnect all sessions for"$sUserNameforSession
Write-Host "Press '3' to Send a Message to all sessions for"$sUserNameforSession
Write-Host "Press '4' to exit without making changes"
$selection = Read-Host "Please make a selection"

switch ($selection)
{

'1' {  

  foreach ($item in $sresult.Results) 
  
  {
     ForceLogoff_User($item)
  }


    
} 

'2' {

  foreach ($item in $sresult.Results) 
  
  {
     Disconnect_User($item)
  }

}

'3' {

 $smessage = Read-Host -Prompt 'Enter the message to send to the users sessions'

  foreach ($item in $sresult.Results) 
  
  {
     SendMessage_User $item $smessage
  }

}

'4'
{
 
  break

}

}

     
                    
}   

function ForceLogoff_User {
 
  try {
             
   
     $script:hvServices.session.Session_LogoffForced($args[0].id)

    }        
           
    catch {
      Write-Host "An error occurred when Logging Off sessions $_"
     break 
    }

    write-host "Logged off session" $args[0].id.id
}

function Disconnect_User {
  
  try {
              
   
     $script:hvServices.session.Session_Disconnect($args[0].id)

    }        
           
    catch {
      Write-Host "An error occurred when disconnecting sessions $_"
     break 
    }

    write-host "Disconnected Session " $args[0].id.id
}

function SendMessage_User {
 
  try {
  
        $script:hvServices.session.Session_SendMessage($args[0].id,"INFO",$args[1])

    }        
           
    catch {
      Write-Host "An error occurred when sending a message $_"
     break 
    }

  write-host "Message Sent to session " $args[0].id.id
    
}

function Show-Menu
  {
    param (
          [string]$Title = 'VMware Horizon PowerCLI Menu'
          )
       Clear-Host
       Write-Host "================ $Title ================"
             
       Write-Host "Press '1' to Login to Horizon"
       Write-Host "Press '2' to return sessions by Username"
       Write-Host "Press 'Q' to quit."
         }

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    
    '1' {  

         LogintoHorizon
    } 
    
    '2' {
   
         GetSessionsByUser

    }
    

}
    pause
}
 
 until ($selection -eq 'q')


