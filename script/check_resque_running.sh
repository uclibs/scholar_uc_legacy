#!/bin/bash

# Check if resque workers are running

if ps aux | grep -v grep | grep resque | grep 'Waiting for' > /dev/null 2>&1
  then
    sleep 1;
  else
    echo "Hydra server $1 appears to have no resque workers running.  Run /srv/apps/curate_uc/script/restart_resque.sh to restart them." > /tmp/resquealert
    sleep 1
    mail -s "Scholar resque workers not running on $1" scholar@uc.edu < /tmp/resquealert
fi

