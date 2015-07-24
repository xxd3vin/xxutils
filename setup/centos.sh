#!/bin/bash

. functions

# base system

yum -y install wget

## RHEL/CentOS 6 64-Bit ##
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm -O /tmp/epel-release-6-8.noarch.rpm
rpm -ivh /tmp/epel-release-6-8.noarch.rpm

install_java_1_6

installapacheUser
