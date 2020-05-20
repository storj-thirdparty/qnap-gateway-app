#!/bin/bash
# This script starts GATEWAY 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "GATEWAY is being run" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
CONTAINER_NAME=storjlabsgateway
#IMAGE_NAME=storjlabs/gateway:ca666a0-v1.1.1-go1.13.8

echo `date` " Starting Tardigrade Gateway ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd="docker run -d --name ${CONTAINER_NAME} -v $(pwd)/gateway:/root/.local/share/storj/gateway storjlabs/gateway:ca666a0-v1.1.1-go1.13.8 run"

echo "$cmd" >> $LOG
output=`$cmd >> $LOG 2>&1 `
echo $output >> $LOG 
echo $output 
sleep 3
output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

