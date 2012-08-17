#!/bin/bash

VER=$1
TOMCAT_DIR=$HOME/ProgramFiles/jscp

if [ "x$VER" = "x" ] ; then
	VER=6
fi

rm -rf $TOMCAT_DIR/apache-tomcat-$VER*/webapps/jspc-samplewar*
cp target/jspc-samplewar.war $TOMCAT_DIR/apache-tomcat-$VER*/webapps
