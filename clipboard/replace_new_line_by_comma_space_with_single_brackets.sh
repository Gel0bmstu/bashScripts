#!/bin/bash

xclip -selection clipboard -o | sed -z "s/\n/', '/g" | xclip -selection clipboard -i
