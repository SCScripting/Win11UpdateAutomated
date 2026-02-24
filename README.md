Use this to run automated updates to Windows 11. 

Run the win11capable.ps1 to create a report telling us whether or not it is capable
Run win11upgrader.ps1 to run the actual update. Uses the windows 11 update assistant to pull the files, install, and automatically upgrade in the background. Restart processes automatically 30 minutes after install is complete. 

KNOWN ERRORS: If there was a version change recently (ie 25H1-25H2 update) there will an error from a blocking folder. Run the block removal script and then proceed with the updater and it will work. 
