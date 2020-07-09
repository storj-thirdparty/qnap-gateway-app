#!/bin/bash
# This script starts GATEWAY 

function setupEnv() {
    dirpath=$(dirname $0)
    export PATH=$PATH:$dirpath
    . common.sh
}
setupEnv 

LOG=$LOGFILE

if [[ $# -lt 1 ]]
then
    msg="Not enough parameters to run gateway"
    echo "$msg"
    echo "$msg" >> "$LOG"
    exit 1
fi
echo "$(date)" "GATEWAY is being run" >> "$LOG"

export PATH=$PATH:${SYS_QPKG_INSTALL_PATH}/container-station/bin
CONTAINER_NAME=storjlabsgatewayrun

moduleBase=$1

echo $(date) " Starting Tardigrade Gateway ${CONTAINER_NAME} ---> " >> "$LOG"
docker ps -a  >> $LOG
cmd="docker run -d --name ${CONTAINER_NAME} -p 127.0.0.1:7777:7777 -v ${moduleBase}/gateway:/root/.local/share/storj/gateway storjlabs/gateway:latest run"

echo "$cmd" >> "$LOG"
output=`$cmd >> $LOG 2>&1 `
echo "$output" >> "$LOG" 
echo "$output" 
sleep 3
output=$(docker ps -a )
echo "$output" >> "$LOG" 
cat <<< $output

