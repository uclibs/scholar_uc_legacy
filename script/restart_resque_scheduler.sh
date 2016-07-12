#!/bin/bash
#
# Stops and then starts resque-scheduler in either production or development environment
# script/restart_resque_scheduler.sh [production|development]

ENVIRONMENT=$1
RESQUE_SCHEDULER_PIDFILE="/tmp/scholar-resque-scheduler.pid"
APP_DIRECTORY="/srv/apps/curate_uc"

cd $APP_DIRECTORY
script/kill_resque_scheduler.sh
sleep 60

BACKGROUND=yes PIDFILE=$RESQUE_SCHEDULER_PIDFILE RAILS_ENV=$ENVIRONMENT LOGFILE=$APP_DIRECTORY/log/resque-scheduler.log bundle exec rake resque:scheduler
