
#
# Create a ssh-agent if non is running and persist it in ~/.ssh/agent.env for reuse.
env=~/.ssh/agent.env

function agent_load_env {
  test -f "$env" && . "$env" >| /dev/null ;
}

function agent_start {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ;
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

#------------------------------------------------------------------------------------------

# Add ssh autocompletion based on ~/.ssh/config
function __ssh_autocomplete {
   cat ~/.ssh/config | grep "Host " | sed "s/Host //" | tr " " "\n"
}
complete -W "$(__ssh_autocomplete)" ssh