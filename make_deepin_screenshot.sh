!#/bin/bash

xfce4-clipman > /dev/null 2>&1 & 
deepin-screenshot -n
pkill "xfce4-clipman"
