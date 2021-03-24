#!/bin/bash

touchpad_id=$(xinput list \
        | grep TouchPad \
        | awk -F '=' '{print $2}' \
        | awk -F ' ' '{print $1}') &&
prop_id=$(xinput list-props $touchpad_id \
        | grep -E 'libinput Accel Speed \([0-9]*\)' \
        | awk '{print $4}' \
        | grep -oh '[0-9]*') &&
xinput --set-prop $touchpad_id $prop_id "$1"
