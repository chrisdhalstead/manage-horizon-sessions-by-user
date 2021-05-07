# Manage-Horizon-Sessions-By-User
Export VMware Horizon Session Data into .CSV

This script will allow you to list and manage the active Horizon sessions for a iunh

***<u>There is no support for this tool - it is provided as-is</u>***

Please provide any feedback directly to me - my contact information: 

Chris Halstead - Staff Architect, VMware  
Email: chalstead@vmware.com  
Twitter: @chrisdhalstead  <br />

This script requires Horizon 7 PowerCLI - https://blogs.vmware.com/euc/2020/01/vmware-horizon-7-powercli.html <br/>

Updated May 7, 2021<br />

------

### Script Overview

This is a PowerShell script that uses PowerCLI and the View-API to query Horizon sessions.  The session are written to a table in the script and also to a .CSV file that can be opened in Excel or a similar spreadsheet tool.

### Script Usage

Run `Horizon - Sessions.ps1` 


   ![Menu](https://github.com/chrisdhalstead/horizon-sessions/blob/main/Images/sessionmenu.PNG)

   #### Login to Horizon Connection Server

Choose **1** to Login to a Horizon Connection Server 

- Enter the FQDN of the server when prompted to "Enter the Horizon Server Name" hit enter

- Enter the Username of an account with Administrative access to the Horizon Server you are connecting to when prompted to "Enter the Username" hit enter

- Enter that users Password and click enter

- Enter that users Domain and click enter

  You will see that you are now logged in to Horizon - click enter to go back to the menu

   ![Login](https://github.com/chrisdhalstead/horizon-sessions/blob/main/Images/Login.PNG)

#### Return Horizon Sessions

Choose **2** to return Horizon Sessions.  They will be written to a table and also to a .CSV file in My Documents.

   ![Sessions](https://github.com/chrisdhalstead/Horizon-Sessions/blob/main/Images/horizonsessions.png)

Note that the location of the .CSV file will be written out after the script executes.

