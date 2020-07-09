#!/bin/bash
# This script extracts the secret key and access key of  the gateway 
function setupEnv() {
    dirpath=$(dirname $0)
    export PATH=$PATH:$dirpath
    . common.sh
}
setupEnv 

LOG=$LOGFILE
echo "$(date)" "Gateway parameter extraction" >> "$LOG"
export PATH=$PATH:${SYS_QPKG_INSTALL_PATH}/container-station/bin
moduleBase=${WEB_PATH}/${PKGNAME}
docker run --rm -v ${moduleBase}/gateway:/root/.local/share/storj/gateway --entrypoint /bin/cat storjlabs/gateway:latest /root/.local/share/storj/gateway/config.yaml

