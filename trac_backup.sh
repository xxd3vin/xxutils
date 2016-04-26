#!/bin/bash

dest="/home/glue/backup/trac_svn"
env="glue"

trac-admin /home/trac/glue hotcopy $dest/${env}.bak

cd $dest
tar zcf trac_`date +"%Y-%m-%d"`.tar.gz ${env}.bak

rm -rf *.bak

#EOF
