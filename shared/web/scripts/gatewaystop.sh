#!/bin/bash
# This script stops GATEWAY 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "GATEWAY is being stopped " >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
CONTAINER_NAME=storjlabsgatewayrun

echo `date` " Stopping  ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd=`docker stop ${CONTAINER_NAME} 2>&1 `
if [[ "x$cmd" == "x${CONTAINER_NAME}" ]]
then
	output="Success in stopping Tardigrade Gateway ${CONTAINER_NAME}"
fi
echo "$cmd" >> $LOG
echo $cmd
output=`docker rm ${CONTAINER_NAME} 2>&1 `
if [[ "x$output" == "x${CONTAINER_NAME}" ]]
then
	output="Success in removing Tardigrade Gateway ${CONTAINER_NAME} "
fi
echo $output >> $LOG
echo $output

