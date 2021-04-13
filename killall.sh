#/bin/bash

ps aux | grep $1 | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ /g' | xargs kill
