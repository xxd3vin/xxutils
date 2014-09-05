#!/bin/bash

##################################################################
# Purpose: Run command on remote server, return 0 if success.
# Arguments:
#   $1 -> IP of remote server.
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

##################################################################
# Purpose: Get all developers in glue project.
#          Since all developers have put their name in wiki, we
#          will filter out their name from wiki txt.
# Return: NO (will create a file "userlist.txt")
##################################################################
function getusers()
{
    local url="http://glue.spolo.org/trac/glue/wiki/SandBox"
    #local url="http://glue.spolo.org/trac/glue/wiki/%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%E4%BF%A1%E6%81%AF?format=txt"
    curl -u ci:sp12345678 "$url" 2>/dev/null | grep "@spolo.org"|sed -e 's/^.*!\(.*\)@spolo\.org.*$/\1/g' | sed -e '/liwei/d;/hanlu/d;/changyushan/d;/peizhelun/d;/tangying/d' > userlist.txt
}

##################################################################
# Purpose: Send email from ci@spolo.org
#          Consider use ssmtp program to send mail.
# Arguments:
#   $1 -> Email subject.
#   $2 -> Email body.
#   $3 -> Email to who.
# Return: NO
##################################################################
function xsendmail()
{
    echo -e "$2" | mail -s "$1" "$3" -a "From: Hudson <ci@spolo.org>"
}
