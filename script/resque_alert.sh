#!/bin/bash

RESQUE_POOL_PIDFILE="/tmp/scholar-resque-pool.pid"
RESQUE_STATUSFILE="/tmp/badresqueprocesses"
EMAIL_TO="hortongn@ucmail.uc.edu"

# Get the PID of the resque pool
[ -f $RESQUE_POOL_PIDFILE ] && {
    PID=$(cat $RESQUE_POOL_PIDFILE)
}

# Find any resque processes that are not part of the current pool
ps -ef | grep -v grep | grep -v alert | grep -v $PID | grep resque > $RESQUE_STATUSFILE

# Send an email if the previous step found rogue resque processes
if [ -s "$RESQUE_STATUSFILE" ]
then
  mail -s "Bad resque workers detected on Scholar $1" $EMAIL_TO < $RESQUE_STATUSFILE
fi
