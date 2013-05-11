#!/bin/bash

pushd `dirname $0`
BASE_DIR=`pwd`
popd

BUILD_CMD=$BASE_DIR/build.sh
DEPLOY_CMD=$BASE_DIR/deploy.sh

bash $BUILD_CMD tomcat5
bash $DEPLOY_CMD 5 on

bash $BUILD_CMD tomcat6
bash $DEPLOY_CMD 6 on

bash $BUILD_CMD tomcat7
bash $DEPLOY_CMD 7 on

