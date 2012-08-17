#!/bin/bash

JSPC_DIR=$HOME/workspace/jspc
REPO_DIR=$HOME/.m2/repository/org/codehaus/mojo/jspc/

rm -rf $REPO_DIR

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
mvn package -U -debug
echo "##########################"
echo "### FINISHED SAMPLEWAR ###"
echo "##########################"
