#!/bin/bash

function print_usage {
  echo "Missing required parameter(s)."
  echo "Usage: $0 [image name] [container name] [bind mount path] [port-redirect] <test>."
  echo "Passing 'test' as the final option will simply print out the results of mapping your arguments to variabels within the script."
  echo "Example: $0 ubuntu ubu-test-1 /usr/share/containers/ubu-test-1 54111"
}

function launch_instance {
  echo "Image: $IMAGE"
  echo "Name: $NAME"
  echo "Mount point: $MOUNT_PATH"
  echo "ID: $ID"
  echo "VID: $VID"
  echo "DO_INI: $DO_INIT"
  echo "GIT_URL: $GIT_URL"
  echo "Command to execute:"
  echo "sudo docker run -d -p $PORT:3000 -name=\"$NAME\" $IMAGE"
  ID=$(sudo docker run -d -e GIT_URL=$GIT_URL -e DO_INIT=$DO_INIT -p $PORT:3000 -name="$NAME" $IMAGE)
  if [[ $? -ne 0 ]]; then
    echo "Error starting docker instance."
    echo $ID
    exit 0
  fi
}

function get_volume_id {
  VID=$(sudo docker inspect $ID | grep -A 1 '"Volumes":' | grep '/srv/express' | grep -v '{}' | awk '{ print $2 }' | sed -e 's/^"//'  -e 's/"$//')
}

function bind_mount {
  #cUID=echo "$(id -u)"
  #cGID=echo "$(id -g)"
  sudo mount --bind $VID $MOUNT_PATH
  #ln -s $VID $MOUNT_PATH
  if [[ $? -eq 0 ]]; then
    echo "Successfully linked $VID to $MOUNT_PATH."
    sudo mount -o remount,uid=$UID,gid=$GID,rw $MOUNT_PATH
    if [[ $? -eq 0 ]]; then
      echo "Successfully remounted $MOUNT_PATH, with current user permissions."
    else
      echo "Unable to remount $MOUNT_PATH. You will need to manually modify permissions."
    fi
  else
    echo "Linking failed."
    show_progress
    exit 0
  fi
}

function show_progress {
  echo "Image: $IMAGE"
  echo "Name: $NAME"
  echo "Mount point: $MOUNT_PATH"
  echo "ID: $ID"
  echo "VID: $VID"
  echo "DO_INI: $DO_INIT"
  echo "GIT_URL: $GIT_URL"
}

function test_request {
  show_progress
  exit 0
}
GIT_URL=""
if [[ $# -lt 4 || $# -gt 6 ]]; then
  print_usage
  exit 0
elif [[ $# -eq 4 ]]; then
  IMAGE=$1
  NAME=$2
  MOUNT_PATH=$3
  PORT=$4
  DO_INIT=1
  launch_instance
  get_volume_id
  bind_mount
elif [[ $# -eq 5 ]]; then
  if [[ $5 == 'test' || $5 == 'TEST' || $5 == 'Test' ]]; then
    test_request
  fi
  IMAGE=$1
  NAME=$2
  MOUNT_PATH=$3
  PORT=$4
  GIT_URL=$5
  launch_instance
  get_volume_id
  bind_mount
elif [[ $# -eq 6 ]]; then
  if [[ $6 == 'test' || $6 == 'TEST' || $6 == 'Test' ]]; then
    test_request
  else
    print_usage
  fi
fi
