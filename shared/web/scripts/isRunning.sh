#!/bin/bash
# This script checks the running of gateway container
function setupEnv() {
    dirpath=$(dirname $0)
    export PATH=$PATH:$dirpath
    . common.sh
}
setupEnv 

LOG=$LOGFILE
CONTAINER_NAME=storjlabsgatewayrun
if [[ $# -gt 0 ]]
then
    CONTAINER_NAME="$1"
fi
echo "$(date)" "checking run status ${CONTAINER_NAME}" >> "$LOG"

export PATH=$PATH:${SYS_QPKG_INSTALL_PATH}/container-station/bin
status=$(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME} 2>/dev/null )
echo "Run Status($CONTAINER_NAME) : #${status}# " >> "$LOG" 

if [[ "$status" == "true" ]]
then
	echo 1
else
	echo 0
fi
