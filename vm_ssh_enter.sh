#!/usr/bin/env bash

ip=$(virsh net-dhcp-leases default | grep -oh -e "192.168.122.[1-9]*" | dmenu "$@");

echo "ip is: $ip";

[[ -n $ip ]] || exit;

ssh-keygen -R $ip && ssh -o "StrictHostKeyChecking no" root@$ip;
