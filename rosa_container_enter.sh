#!/bin/bash

rosa_running_status=$(sudo docker ps -a -f 'status=running' -f 'name=rosa' | wc -l)

if [ $rosa_running_status -ne 2 ]; then
  echo 'Rosa container is DOWN, restarting now';
  sudo docker start rosa ;
fi

echo 'Entering rosa container ...'

sudo docker exec -ti -u omv rosa /bin/bash 

