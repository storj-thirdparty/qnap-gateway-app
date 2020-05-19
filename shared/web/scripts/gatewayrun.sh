#!/bin/bash
# This script starts GATEWAY 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "GATEWAY is starting" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
IPADDR=$(ip -4 -o addr show eth0 | awk '{print $4}' | cut -d "/" -f 1)
#PORTADDR=$(sed -e 's#.*:\(\)#\1#' <<< "${1}")
CONTAINER_NAME=storjlabsgateway
IMAGE_NAME= storjlabs/gateway:ca666a0-v1.1.1-go1.13.8

echo `date` " Starting Storagenode ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd= "docker run -d --name ${CONTAINER_NAME} -v $(pwd)/gateway:/root/.local/share/storj/gateway ${IMAGE_NAME} run"

echo "$cmd" >> $LOG
$cmd >> $LOG 2>&1 
echo $output >> $LOG 
echo $output 
output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

