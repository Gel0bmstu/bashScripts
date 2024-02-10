#!/bin/bash

if [[ -z $(cat /etc/resolv.conf | grep "10.43.0.10") ]]; then 
        echo "nameserver 10.43.0.10" >> /etc/resolv.conf
        echo "append 10.43.0.10"
fi

if [[ -z $(cat /etc/resolv.conf | grep "10.96.0.10") ]]; then 
        echo "nameserver 10.96.0.10" >> /etc/resolv.conf
        echo "append 10.96.0.10"
fi
