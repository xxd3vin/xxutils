#!/bin/bash

script_name=$0

ticket_list=(
)

# debug ticket
ticket_list=(
18654
)

author="ci"
component="wware后端"
milestone=""
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
  sudo python updateticket.py -i $ticket_id -c "$script_name" -a "$author" -C "$component" -m "$milestone" -t "$_type"
done
