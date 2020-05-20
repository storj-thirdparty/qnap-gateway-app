#!/bin/bash
# This script configures the gateway 
PKGNAME="GATEWAY"
LOG="/var/log/$PKGNAME"
echo `date` "Gateway is getting configured" >> $LOG

export PATH=$PATH:/share/CACHEDEV1_DATA/.qpkg/container-station/bin
CONTAINER_NAME=storjlabsgateway
docker run --rm -v $(pwd)/gateway:/root/.local/share/storj/gateway --entrypoint /bin/rm storjlabs/gateway:ca666a0-v1.1.1-go1.13.8 -f /root/.local/share/storj/gateway/config.yaml

echo `date` " Saving Configuration of  ${CONTAINER_NAME} ---> " >> $LOG
docker ps -a  >> $LOG
cmd="docker run --rm --name ${CONTAINER_NAME} -p ${1} -v $(pwd)/gateway:/root/.local/share/storj/gateway storjlabs/gateway:ca666a0-v1.1.1-go1.13.8 setup --satellite-address ${2} --api-key ${3} --passphrase ${4} --non-interactive"

echo "RUNNING ----------- $cmd ------------- " >> $LOG
output=`$cmd 2>&1  `
echo $output >> $LOG 
cat <<< $output

output=`docker ps -a `
echo $output >> $LOG 
cat <<< $output

