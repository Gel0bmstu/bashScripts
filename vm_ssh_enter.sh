#!/usr/bin/env bash

ip=$(virsh net-dhcp-leases default | grep -oh -e "192.168.122.[0-9]*" | dmenu "$@");

[[ -n $ip ]] || exit;

echo "ip is: $ip";

ssh-keygen -R $ip && sshpass -p 123 ssh -o "StrictHostKeyChecking no" root@$ip;

if [ $? != 0 ]; then
        ssh-keygen -R $ip && sshpass -p 1q2w3e4r%T^Y ssh -o "StrictHostKeyChecking no" root@$ip;
fi
