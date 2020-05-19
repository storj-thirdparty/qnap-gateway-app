#!/bin/bash
# This script stops GATEWAY 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "GATEWAY is being stopped " >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
CONTAINER_NAME=storjlabsgateway

echo `date` " Stopping  ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd= "docker stop ${CONTAINER_NAME}"
echo "$cmd" >> $LOG
$cmd >> $LOG 2>&1 

cmd= "docker rm ${CONTAINER_NAME}"
echo "$cmd" >> $LOG
$cmd >> $LOG 2>&1 

output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

