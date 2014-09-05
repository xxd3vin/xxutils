#!/bin/bash

##################################################################
# Purpose: Run command on remote server, return 0 if success.
# Arguments:
#   $1 -> IP of remote server
#   $2 -> Command to be executed.
# Return: 0(True) or 1(False)
##################################################################
function rcmd()
{
    local ip="$1"
    local cmd="$2"
    echo -e "\n$cmd\n---------------------"
    ssh -t -t -o ConnectTimeout=8 -o StrictHostKeyChecking=no chenyang@$ip "$cmd" && return 0 || return 1 </dev/null
}
