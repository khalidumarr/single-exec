#!/bin/bash

############################################
########### SETUP VARIABLES ################
############################################
for last; do true; done
TASK_NAME=`echo $last|sed -e "s/\//_/g"`
PIDFILE_PATH=$1
PIDFILE=$PIDFILE_PATH'/'$TASK_NAME'.pid'

############################################
############ LOCKING LOGIC #################
############################################
if [ ! -d $PIDFILE_PATH ]; then
    mkdir data/tmp
fi

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi
 
############################################
############ EXECUTING TASK ################
############################################
shift
$@

############################################
########### Removing PIDFILE ###############
############################################
rm $PIDFILE