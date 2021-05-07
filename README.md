# Manage-Horizon-Sessions-By-User
Export VMware Horizon Session Data into .CSV

This script will allow you to list and manage the active Horizon sessions for a user

***<u>There is no support for this tool - it is provided as-is</u>***

Please provide any feedback directly to me - my contact information: 

Chris Halstead - Staff Architect, VMware  
Email: chalstead@vmware.com  
Twitter: @chrisdhalstead  <br />

This script requires Horizon 7 PowerCLI - https://blogs.vmware.com/euc/2020/01/vmware-horizon-7-powercli.html <br/>

Updated May 7, 2021<br />

------

### Script Overview

This is a PowerShell script that uses PowerCLI and the View-API to query Horizon sessions.  You can search for sessions by user and log them off, disconnect them or send them a message

### Script Usage

Run `Manage-Horizon-Sessions-ByUser.ps1` 


   ![Menu](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/mainmenu.PNG)

   #### Login to Horizon Connection Server

Choose **1** to Login to a Horizon Connection Server 

- Enter the FQDN of the server when prompted to "Enter the Horizon Server Name" hit enter

- Enter the Username of an account with Administrative access to the Horizon Server you are connecting to when prompted to "Enter the Username" hit enter

- Enter that users Password and click enter

- Enter that users Domain and click enter

  You will see that you are now logged in to Horizon - click enter to go back to the menu

   ![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/Login.PNG)

#### Return Horizon Sessions

Choose **2** to return Horizon Sessions.  You will be prompted for the username to search for.  

   ![Sessions](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/getsession.png)

