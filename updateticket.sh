#!/bin/bash

ticket_list=(
)

#ticket_list=(
#17912
#)

author="ci"
component="wware后端"
milestone="[wware] videoplayer.com 视频播放器"
#owner="chenyang"
_type="动态化"

for ticket_id in ${ticket_list[@]}
do
  echo $ticket_id
  #cmd="python updateticket.py"
  #cmd="$cmd -i $ticket_id"
  #cmd="$cmd -c \"updateticket.py\""
  #cmd="$cmd -a \"$author\""
  #cmd="$cmd -C \"$component\""
  #cmd="$cmd -m \"$milestone\""
  #cmd="$cmd -o \"$owner\""
  #cmd="$cmd -t \"$_type\""
  #cmd="$cmd -s \"assigned\""
  #echo $cmd
  sudo python updateticket.py -i $ticket_id -c "updateticket.py" -a "$author" -C "$component" -m "$milestone" -t "$_type"
done
