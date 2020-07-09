#!/bin/bash
# This script stops GATEWAY 
function setupEnv() {
    dirpath=$(dirname $0)
    export PATH=$PATH:$dirpath
    . common.sh
}
setupEnv 

LOG=$LOGFILE
echo "$(date)" "GATEWAY is being stopped " >> "$LOG"

export PATH=$PATH:${SYS_QPKG_INSTALL_PATH}/container-station/bin
CONTAINER_NAME=storjlabsgatewayrun

echo $(date) " Stopping  ${CONTAINER_NAME} ---> " >> "$LOG"
docker ps -a  >> "$LOG"
cmd= $(docker stop ${CONTAINER_NAME} 2>&1 )
if [[ "x$cmd" == "x${CONTAINER_NAME}" ]]
then
	output="Success in stopping Tardigrade Gateway ${CONTAINER_NAME}"
fi
echo "$cmd" >> "$LOG"
echo "$cmd"
output= $(docker rm ${CONTAINER_NAME} 2>&1 )
if [[ "x$output" == "x${CONTAINER_NAME}" ]]
then
	output="Success in removing Tardigrade Gateway ${CONTAINER_NAME} "
fi
echo "$output" >> "$LOG"
echo "$output"

