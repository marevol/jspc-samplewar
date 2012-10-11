#!/bin/bash

VER=$1
CONTENT_CHECK=$2
TOMCAT_DIR=$3

if [ "x$VER" = "x" ] ; then
	VER=6
fi
if [ "x$TOMCAT_DIR" = "x" ] ; then
	TOMCAT_DIR=$HOME/ProgramFiles/jscp
fi

echo "########################"
echo "### DEPLOY SAMPLEWAR ###"
echo "########################"

TOMCAT_HOME_DIR=$TOMCAT_DIR/apache-tomcat-$VER*
TOMCAT_WEBAPPS_DIR=$TOMCAT_HOME_DIR/webapps
echo "Copy jspc-samplewar.war to $TOMCAT_WEBAPPS_DIR"
rm -rf $TOMCAT_DIR/apache-tomcat-$VER*/webapps/jspc-samplewar*
cp target/jspc-samplewar.war $TOMCAT_WEBAPPS_DIR
ERR_CODE=`echo $?`

if [ x$ERR_CODE != "x0" ] ; then
    exit $ERR_CODE;
fi

if [ "x$CONTENT_CHECK" = "xon" ] ; then
    echo "Cleaning log files..."
	rm $TOMCAT_HOME_DIR/logs/*
    echo "Starting Tomcat ${VER}..."
	bash $TOMCAT_HOME_DIR/bin/startup.sh
    sleep 3
    echo "### CONTENT BEGIN ###"
    curl http://localhost:8080/jspc-samplewar/
    echo "### CONTENT END ###"
    echo "Shuting down Tomcat ${VER}..."
	bash $TOMCAT_HOME_DIR/bin/shutdown.sh
fi
