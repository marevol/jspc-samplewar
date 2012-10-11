#!/bin/bash

REPO_DIR=$HOME/.m2/repository/org/codehaus/mojo/jspc
rm -rf ${REPO_DIR}*

PROFILE_NAME=$1
JSPC_DIR=$2

if [ "x$JSPC_DIR" = "x" ] ; then
	JSPC_DIR=$HOME/workspace/jspc
fi

if [ "x$PROFILE_NAME" = "x" ] ; then
	PROFILE_NAME=tomcat6
fi

echo "##################"
echo "### BUILD JSPC ###"
echo "##################"
pushd $JSPC_DIR
mvn clean
mvn install -U -debug
ERR_CODE=`echo $?`
popd

if [ x$ERR_CODE != "x0" ] ; then
    exit $ERR_CODE;
fi

echo "#######################"
echo "### BUILD SAMPLEWAR ###"
echo "#######################"
mvn clean
mvn package -U -debug -P $PROFILE_NAME
echo "##########################"
echo "### FINISHED SAMPLEWAR ###"
echo "##########################"
