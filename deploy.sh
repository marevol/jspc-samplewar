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
    count=0
    while [ $count -lt 30 ] ; do
        grep "Server startup" $TOMCAT_HOME_DIR/logs/catalina.out > /dev/null 2>&1
        rst=$?
        if [ $rst -eq 0 ] ; then
            count=30
        else
            sleep 1
            count=`expr $count + 1`
        fi
    done
    HEAD_FILE=/tmp/head_$$.txt
    CONTENT_FILE=/tmp/content_$$.txt
    curl -D $HEAD_FILE -o $CONTENT_FILE http://localhost:8080/jspc-samplewar/
    echo "### HEAD BEGIN ###"
    cat $HEAD_FILE
    echo "### HEAD END ###"
    echo "### CONTENT BEGIN ###"
    cat $CONTENT_FILE
    echo "### CONTENT END ###"
    rm $HEAD_FILE
    rm $CONTENT_FILE
    echo "Shuting down Tomcat ${VER}..."
	bash $TOMCAT_HOME_DIR/bin/shutdown.sh
fi
