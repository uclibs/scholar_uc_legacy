#!/bin/bash
#
# Stops the current resque-scheduler

RESQUE_SCHEDULER_PIDFILE="/tmp/scholar-resque-scheduler.pid"

if [ -f $RESQUE_SCHEDULER_PIDFILE ]; then
  PID=$(cat $RESQUE_SCHEDULER_PIDFILE)
  kill -2 $PID
  rm $RESQUE_SCHEDULER_PIDFILE
fi
