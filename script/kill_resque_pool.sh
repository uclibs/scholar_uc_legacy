#!/bin/bash
#
# Stops the current resque-pool

RESQUE_POOL_PIDFILE="/tmp/scholar-resque-pool.pid"

[ -f $RESQUE_POOL_PIDFILE ] && {
    PID=$(cat $RESQUE_POOL_PIDFILE)
    CPIDS=$(pgrep -P $PID)
    kill -2 $PID
    sleep 5
    (kill -2 $CPIDS &)
}
