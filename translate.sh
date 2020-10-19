#!/bin/bash

selected_text="$(xclip -o)"
echo $selected_text
translated_text=$(trans :ru --brief "$selected_text")
echo $translated_text

zenity --info --text="$translated_text"
