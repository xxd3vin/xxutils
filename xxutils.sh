#!/bin/bash

# run command on remote server
rcmd()
{
    local ip="$1"
    local cmd="$2"
    echo -e "\n$cmd\n---------------------"
    ssh -t -t -o ConnectTimeout=8 -o StrictHostKeyChecking=no chenyang@$ip "$cmd"</dev/null
}
