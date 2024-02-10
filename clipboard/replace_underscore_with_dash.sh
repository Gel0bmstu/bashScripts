#!/bin/bash

xclip -selection clipboard -o | sed -z 's/_/-/g' | xclip -selection clipboard -i
