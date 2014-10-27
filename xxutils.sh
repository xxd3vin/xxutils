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
# Purpose: Send file to remote, and run it on remote.
# Arguments:
#   $1 -> IP of remote server.
#   $2 -> File with command to be executed.
# Return: 0(True) or 1(False)
##################################################################
function rcmdfile()
{
    local ip="$1"
    local cmdfile="$2"
    local remotedir=$( gettmpdir "rcmdfile" 0 )
    rcmd $ip "mkdir -p $remotedir"
    scp -o ConnectTimeout=8 -o StrictHostKeyChecking=no "$cmdfile" chenyang@$ip:$remotedir/$cmdfile
    rcmd $ip "chmod a+x $remotedir/$cmdfile ; $remotedir/$cmdfile"
}

##################################################################
# Purpose: Generate random name dir in /tmp.
# Arguments:
#   $1 -> Dir name prefix.
#   $2 -> If 0, dont make dir.
# Return: dir name
##################################################################
function gettmpdir()
{
    local remotedir="/tmp/$1_$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM"
    if [ "X$2" != "X0" ];
    then
        mkdir -p $remotedir
    fi
    echo $remotedir
}

##################################################################
# Purpose: Get all developers in glue project.
#          Since all developers have put their name in wiki, we
#          will filter out their name from wiki txt.
# Return: NO (will create a file "userlist.txt")
##################################################################
function getusers()
{
    #local url="http://glue.spolo.org/trac/glue/wiki/SandBox?format=txt"
    local url="http://glue.spolo.org/trac/glue/wiki/%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%E4%BF%A1%E6%81%AF?format=txt"
    curl -u ci:sp12345678 "$url" 2>/dev/null | grep "@spolo.org"|sed -e 's/^.*!\(.*\)@spolo\.org.*$/\1/g' | sed -e '/liwei/d;/hanlu/d;/changyushan/d;/peizhelun/d;/tangying/d;/lizhutang/d;/masol/d' > userlist.txt
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

##################################################################
# Purpose: Print log to file.
# Env:
#   $XLOG_SHELLNAME: Shell script name.
#   $XLOG_LOGNAME: Absoluted path of log file.
# Arguments:
#   $1 -> Log message.
# Return: NO
##################################################################
function xlog()
{
    if [ "X$XLOG_SHELLNAME" = "X" ]
    then
        XLOG_SHELLNAME="/tmp/xlog.default.log"
    fi
    if [ "X$XLOG_LOGNAME" = "X" ]
    then
        XLOG_LOGNAME="xlog.default.sh"
    fi
    echo "`date +"%Y-%m-%d %T"` [$XLOG_SHELLNAME] $1" >> $XLOG_LOGNAME
}
