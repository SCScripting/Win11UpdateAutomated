# Kills old update folders. If computer updated its windows version (ie 25H1-25H2) a version update folder is left where the update script is run
# Clears the folder to allow for updater to process

Remove-Item -Path '$WINDOWS.~WS' -Recurse -Force
