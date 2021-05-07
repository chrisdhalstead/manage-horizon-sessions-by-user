# Manage-Horizon-Sessions-By-User
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


   ![Menu](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/MainMenu.PNG)

   #### Login to Horizon Connection Server

Choose **1** to Login to a Horizon Connection Server 

- Enter the FQDN of the server when prompted to "Enter the Horizon Server Name" hit enter

- Enter the Username of an account with Administrative access to the Horizon Server you are connecting to when prompted to "Enter the Username" hit enter

- Enter that users Password and click enter

- Enter that users Domain and click enter

  You will see that you are now logged in to Horizon - click enter to go back to the menu

   ![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/Login.PNG)

#### Return Horizon Sessions By Username

Choose **2** to return Horizon Sessions.  You will be prompted for the username to search for.  

   ![Sessions](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/getsession.PNG)

If you enter an invalid username or the user has no sessions you will be shown that no sessions could be found for that user

 ![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/nosession.PNG)

If there are sessions you will shown the number of sessions also with details.

 ![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/sessioninitial.PNG)

You will now be presented with a menu to manage the sessions you can:

1. Logoff all sessions for the user
2. Disconnect all sessions for the user
3. Send all of the users sessions a message
4. Exit without making changes

Select a number to proceed with that action.

**3 - Send a Message to all sessions for user - you will be prompted for what message you would like to send.**   

 ![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/sendmessage.PNG)

When you click enter you message will be sent and output will show which sessionIDs it was sent to

![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/messagesent.PNG)

**2  - Disconnect all sessions for user**   

When you select this option, all of the users sessions will be disconnected and you will receive output on which sessionIDs it was applied to

![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/disconnected.PNG)

After we run that action we can look at the sessions again and see they are disconnected.

![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/isdisconnected.PNG)

**1  - Logoff all sessions for user**   

When you select this option, all of the users sessions will be logged off and you will receive output on which sessionIDs it was applied to

![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/logoff.PNG)

If we search again for sessions for this user, you can see that there are none.

![Login](https://github.com/chrisdhalstead/manage-horizon-sessions-by-user/blob/main/Images/nosessions.PNG)



