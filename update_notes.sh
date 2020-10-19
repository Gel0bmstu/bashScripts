#!/bin/bash

joplin sync &&

pushd $NOTES_DIR
rm -rf ./raw/*
--log-level debug export --format raw "$NOTES_DIR/raw"
popd
git add .
git commit -m "update"
