#!/bin/bash
# This script configures the gateway 
PKGNAME="STORJ"
LOG="/var/log/$PKGNAME"
echo `date` "Gateway is getting configured" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
IPADDR=$(ip -4 -o addr show eth0 | awk '{print $4}' | cut -d "/" -f 1)
PORTADDR=$(sed -e 's#.*:\(\)#\1#' <<< "${1}")
CONTAINER_NAME=storjlabsgateway

echo `date` " Saving Configuration of  ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd= "docker run --rm -it --name gateway -p ${PORTADDR}:7777:7777 -v $(pwd)/gateway:/root/.local/share/storj/gateway storjlabs/gateway:f8ef66c-v1.0.4-go1.13.8 --server.address 0.0.0.0:7777"
#cmd="docker run -d --restart no -p ${PORTADDR}:28967 -p ${IPADDR}:14002:14002 -e WALLET=${2} -e EMAIL=${3} -e ADDRESS=${1} -e STORAGE=${4}GB -v ${5}:/app/identity -v ${6}:/app/config --name ${CONTAINER_NAME} storjlabs/storagenode:beta " 
echo "$cmd" >> $LOG
$cmd >> $LOG 2>&1 
echo $output >> $LOG 
echo $output 
output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

