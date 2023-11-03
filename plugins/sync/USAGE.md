# List of commands from plugins/sync #

The following have to be executed from your project root folder:

* `shuite check_remote_repo <servername>`  
  Checks if the according remote repository has uncommited changes or unpushed branches
  that are not present locally and would therefore be overwritten
  by you syncing your local .git-folder.

* `devsync sync <servername>`  
  Syncs your current local directory to the matching project directory on the given server.  
  ~/projects/<name-of-my-local-project-folder>