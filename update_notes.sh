#!/bin/bash

joplin-cc --profile ~/.config/joplin-desktop/ sync &&

pushd /home/gel0/notes
rm -rf ./raw
joplin-cc --profile ~/.config/joplin-desktop/ \
  --log-level debug export --format md "./raw" &&

sudo sqlite3 ~/.config/joplin-desktop/database.sqlite \
  "UPDATE version SET version = 33;"

git add . &&
git commit -m "update" &&
git push &&
popd
