#!/bin/bash

# If file exsits, not first run, so just start node app
if [[ -f /srv/express/package.json ]]; then  
  cd /srv/express
  npm start
# Else, first run, so create node app and exit
else  
  cd /srv/express
  express -s -c less
  curl -L $DEP_URL -o package.json
  npm install
fi  
