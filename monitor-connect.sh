#!/bin/bash

echo "${SRANDRD_OUTPUT} ${SRANDRD_EVENT}" > /tmp/seandrd.log

case "${SRANDRD_OUTPUT} ${SRANDRD_EVENT}" in
  "HDMI-A-0 connected") 
    sudo /root/.screenlayout/top.sh
    echo "HDMI-A-0 connected" >> /tmp/seandrd.log
    ;;
esac
