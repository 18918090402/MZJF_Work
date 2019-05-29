#!/bin/bash

setETLEnv() {
JAVA_HOME="$JAVA_HOME"
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH

export CDH_HOME="/opt/maizi/cloudera/parcels/CDH-5.11.0-1.cdh5.11.0.p0.34"
export PATH=$CDH_HOME/bin:$PATH

export LANG="en_US.UTF-8"

export ETL_FOLDER="/opt/ETL"

export KETTLE_HOME="/opt/ETL/00_PDI_Kettle/data-integration/pwd"
}