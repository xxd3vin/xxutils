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

function getusers()
{
    curl -u ci:sp12345678 http://glue.spolo.org/trac/glue/wiki/%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%E4%BF%A1%E6%81%AF?format=txt 2>/dev/null | grep "@spolo.org"|sed -e 's/^.*!\(.*\)@spolo\.org.*$/\1/g' | sed -e '/liwei/d;/hanlu/d;/changyushan/d;/peizhelun/d;/tangying/d' > userlist.txt
}
