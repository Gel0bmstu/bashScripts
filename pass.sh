#!/usr/bin/env bash

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

export PASSWORD_STORE_DIR="/media/d/passwords"
prefix=$PASSWORD_STORE_DIR
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )


password=$(printf '%s\n' "${password_files[@]}" | dmenu "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
	pass -c "$password" > /dev/null 2>&1
else
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } |
		xdotool type --clearmodifiers --file -
fi
