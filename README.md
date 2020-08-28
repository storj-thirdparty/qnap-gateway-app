# QNAP Tardigrade Gateway

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9d1a6a204b244643a47d7047a16bf05d)](https://app.codacy.com/gh/storj-thirdparty/qnap-gateway-app?utm_source=github.com&utm_medium=referral&utm_content=storj-thirdparty/qnap-gateway-app&utm_campaign=Badge_Grade_Dashboard)



The QNAP Tardigrade Gateway is an application for installing the Tardigrade S3-compatible gateway on a QNAP device. The format of the application installed on the QNAP is .qpkg which is built on the [QDK](https://github.com/qnap-dev/QDK#installation).

<br />

# App Use

**API Key** and **Passphrase** ... Enter your Tardigrade API information and encryption passphrase that you want to use with the Storj-powered Tardigrade network.

**Access Key** and **Secret** ... These items are used by the S3-compatible application you want to interface with the Tardigrade network.

**Start** / **Stop **Gateway - Manually start and stop the gateway.



<br />

## Building Instructions

Install [Entware](https://www.qnapclub.eu/en/qpkg/556) on QNAP.

Once entware is installed, install git with following commands.
```sh
opkg update
opkg install git
```

Cloning the repository.

```bash
$ git clone https://github.com/storj/qnap-gateway-app
$ cd qnap-gateway-qnap
```

Build the front end (requires node js)

``` bash
$ npm install
$ npm run build
```

``` bash
$ qbuild
```
The qpkg file is found at qnap-gateway-app/build](storj-node-qnap/build)

[QPKG Building Instructions](https://edhongcy.gitbooks.io/qdk-quick-start-guide/content/build-your-own-qpkg.html)



### Cheat sheet

- To create a new Project `qbuild --create-env <project-name>`

- Change version number(QPKG_VER) in [qpkg.cfg](qpkg.cfg)

  

## Paths

docker-path - '/share/CACHEDEV1_DATA/.qpkg/container-station/bin/docker'

Actions to the triggers can be found and added in storj-node-qnap/shared/STORJ.sh.
Perform actions accordingly. Give the full path of the executables.
Default actions can be found in the package_routines.
Actions can be fired from system("/etc/init.d/GATEWAY.sh <your-command>") in php script.

Actions that should be executed pre and post the installation of the app is written in package_routines.





# Debug

App is installed at `/share/CACHEDEV1_DATA/.qpkg/GATEWAY. The folder structure is the same as it is in the shared folder. In case the app is misbehaving or needs to be debugged, it can be found here.

If you can't see or access the dashboard try the command **docker container ls -all** to check if the storaganode docker container is running.

## More information
To know more about running the Docker container of Tardigrade Uplink Gateway please see the [Uplink Gateway documentation](https://documentation.tardigrade.io/api-reference/s3-gateway)

