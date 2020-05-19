#!/bin/bash
# This script configures the gateway 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "Gateway is getting configured" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
IPADDR=$(ip -4 -o addr show eth0 | awk '{print $4}' | cut -d "/" -f 1)
#PORTADDR=$(sed -e 's#.*:\(\)#\1#' <<< "${1}")
CONTAINER_NAME=storjlabsgateway

echo `date` " Saving Configuration of  ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd= "docker run --rm -it --name ${CONTAINER_NAME} -p ${1} -v $(pwd)/gateway:/root/.local/share/storj/gateway storjlabs/gateway:ca666a0-v1.1.1-go1.13.8 setup --satellite-address ${3} --api-key ${4} --passphrase ${5} --non-interactive"

echo "$cmd" >> $LOG
$cmd >> $LOG 2>&1 
echo $output >> $LOG 
echo $output 
output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

