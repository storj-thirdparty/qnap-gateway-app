#!/bin/bash

# This script updates the storagenode docker image
# Assumption: # It needs CONFIG_FILE path as a parameter 

PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` $PKGNAME  " docker container updater script running " >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin


# ------------------------------------------------------------------------------
#       Container Updation logic 
# ------------------------------------------------------------------------------
set -e
BASE_IMAGE="storjlabs/gateway:latest"
CONTAINER_NAME=storjlabsgatewayrun
REGISTRY=""
IMAGE="$BASE_IMAGE"

CID=$(docker ps | grep ${CONTAINER_NAME} | awk '{print $1}')

OLD=`docker inspect --format "{{.Id}}" $IMAGE`
docker pull $IMAGE
LATEST=`docker inspect --format "{{.Id}}" $IMAGE`
PORTADDR=$(sed -e 's#.*:\(\)#\1#' <<< "${port}")

if [[ "x${OLD}" != "x${LATEST}" ]]
then
    RUNNING=`docker inspect --format "{{.Image}}" $CID`
    if [ "$RUNNING" != "$LATEST" ];then
        echo `date` "Upgrading $CONTAINER_NAME" >> $LOG
	docker stop $CONTAINER_NAME
        docker rm -f $CONTAINER_NAME
	# ------------------------------------------------------------------
	# Re-start new container with related params
	# ------------------------------------------------------------------
	docker run -d --name ${CONTAINER_NAME} -v ${moduleBase}/gateway:/root/.local/share/storj/gateway storjlabs/gateway:latest run
	echo `date` "Iamge $IMAGE updated (And running container $CONTAINER_NAME updated)" >> $LOG
    else
	echo `date` "Image $IMAGE updated (And no container was running)" >> $LOG
    fi
else
    echo `date` "$IMAGE is already up to date" >> $LOG
fi

# ------------------------------------------------------------------------------
