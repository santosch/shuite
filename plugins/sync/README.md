# SHUITE-Plugin: sync

This plugin adds some functionality for mixed local/remote development (e.g. for performance-reasons).  
It is highly opinionated and most likely at best an inspiration for your own setup or plugin.

This is used to have and edit code in your local WSL
for best compatibility with development tools and indexing 
(e.g. in ~/work/myproject)
but the code is executed on a remote server
(perhaps because there are other applications it needs to interact with).

## Prerequisites
- rsync installed
- your project is a git repository
- the remote project is located in ~/projects/<name-of-my-local-project-folder>
- your project contains a .rsyncignore file which configures which files to synchronize

## !!! WARNING !!!

- by syncing your local project to the remote server **FILES MAY BE OVERWRITTEN OR DELETED ON THE REMOTE**
- if the .git-Folder is synchronized as well (recommended) then unpushed changes on the remote may be lost as well
- to make your setup more secure you can use the function `check_remote_repo`, see USAGE.md

### USE EVERYTHING ON YOUR OWN RISK   
**DO NOT USE WITH PRODUCTION ENVIRONMENTS, THIS IS INTENDED FOR DEVELOPMENT-ENVIRONMENTS**  
**DO NOT USE IF YOU DO NOT UNDERSTAND WHAT THIS IS DOING**  

## Hints
- If rsync fails suddenly with some files, 
  make sure you have the same version of rsync installed locally and on the server.
- The format of the .rsyncignore file follows the scheme for the rsync argument `--exclude-from`,  
  read about it here: https://stackoverflow.com/a/23682701
- It might make sense to add a File-Watcher triggering this to your IDE.  
  For IntelliJ-based IDEs you can do so via *Settings -> Tools -> File Watchers -> +*
  *Program*:           `wsl`  
  *Arguments*:         `-d "Ubuntu-22.04" bash --login -i -c "shuite sync my-server"`  
  *Working directory*: your project root