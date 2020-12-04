#!/bin/bash

pushd $HOME/dotfiles
python3 $BASHSCRIPTS_DIR/gcp.py
popd

pushd $HOME/bashscripts
python3 $BASHSCRIPTS_DIR/gcp.py
popd

$BASHSCRIPTS_DIR/update_notes.sh
