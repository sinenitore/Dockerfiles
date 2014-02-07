#!/bin/bash

function usage {
  printf "Script for stop and removing a docker container, and unmounting the associated volume.\n"
  printf "Usage: $0 [container name or id] [path to mount point]\n"
  exit 0
}

function unmount_dir {
  um=$(sudo umount $mPoint)
  if [ $um -eq 0 ]; then
    printf "Successfully unmounted volume.\n"
  else
    printf "Unable to unmount volume: $um\n"
    exit 0
  fi
}

function stop_rm {
  stopRes=$(sudo docker stop $container)
  if [ $stopRes -eq $container ]; then
    printf "Stopped container successfully.\n"
    rmRes=$(sudo docker rm $container)
    if [ $rmRes -eq $container ]; then
      printf "Removed container successfully.\n"
    else
      printf "Unable to remove container: $rmRes\n"
      exit 0
    fi
  else
    printf "Unable to stop container: $stopRes\n"
    exit 0
  fi

}

if [ $# -lt 2 ]; then
  usage
else
  if [ -d "$2" ]; then
    container=$1
    mPoint=$2
    printf "Attempting to stop $1 and unmount $2\n"
    stop_rm
    unmount_dir
  else
    printf "The mount pint path provided isn't valid.\n"
    usage
  fi
fi


