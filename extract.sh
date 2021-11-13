#!/bin/bash

if [ $# -lt 1 ];then
  echo "Usage: `basename $0` FILES"
  exit 1
fi

# I found the following function at https://unix.stackexchange.com/a/168/37944
# which I improved it a little. Many thanks to sydo for this idea.
extract () {
    for arg in $@ ; do
        if [ -f $arg ] ; then
            case $arg in
                *.tar.xz)   tar xvf $arg      ;;
                *.tar.bz2)  tar xvjf $arg      ;;
                *.tar.gz)   tar xvzf $arg      ;;
                *.bz2)      bunzip2 $arg      ;;
                *.gz)       gunzip $arg       ;;
                *.tar)      tar xvf $arg       ;;
                *.tbz2)     tar xvjf $arg      ;;
                *.tgz)      tar xvzf $arg      ;;
                *.zip)      unzip $arg        ;;
                *.Z)        uncompress $arg   ;;
                *.rar)      rar x $arg        ;;  # 'rar' must to be installed
                *.jar)      jar -xvf $arg     ;;  # 'jdk' must to be installed
                *)          echo "'$arg' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$arg' is not a valid file"
        fi
    done
}

extract $@
