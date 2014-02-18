#!/bin/bash

printf "Work Dir: $WORK_DIR"
printf "DO_INIT: $DO_INIT"
printf "GIT_URL: $GIT_URL"

cd $WORK_DIR

# If Do Init is set, create a new express app.
# If not, get current source from GIT_URL
if [[ $DO_INIT -eq 1 ]]; then
  printf "DO_INIT tested to True, inside if."
  express --sessions --css less .
  git init
else
  if [[ $GIT_URL ]]; then
    git clone $GIT_URL
    git remote add origin $GIT_URL
  fi
  printf "DO_INIT is false but no GIT_URL was given, so nothing to do."
  exit 0;
fi

# Run install
npm install

# Set permissions for easy dev access
chmod g+rw -R /srv
chmod o+rw -R /srv

# Launch app using nodemon
nodemon --watch ./routes --watch ./views ./app.js
