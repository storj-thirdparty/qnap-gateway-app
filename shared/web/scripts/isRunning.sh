#!/bin/bash
# This script checks the running of gateway container
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
CONTAINER_NAME=storjlabsgateway
if [[ $# -gt 0 ]]
then
    CONTAINER_NAME=$1
fi
echo `date` "checking run status ${CONTAINER_NAME}" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
status=`docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME} 2>/dev/null `
echo "Run Status($CONTAINER_NAME) : #${status}# " >> $LOG 

if [[ "$status" == "true" ]]
then
	echo 1
else
	echo 0
fi
