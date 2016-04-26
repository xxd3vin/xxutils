#!/bin/bash

dest=/home/glue/backup/trac_svn
repo=glue

svnadmin dump /home/svn/$repo | gzip > $dest/svn_`date +"%Y-%m-%d"`.gz

#EOF
