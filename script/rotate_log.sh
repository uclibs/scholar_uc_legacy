#!/bin/sh

# Move the logs file to a new directory so it isn't lost during deploy

file_name=/srv/apps/curate_uc/log/production.log
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
new_fileName=/srv/apps/curate_uc-logs/production.log.$current_time

if [ -f $file_name ];
then

  # Move the log file to a new directory and add timestamp
  mv $file_name $new_fileName

  # Compress the moved log file
  gzip $new_fileName

fi

# Restart the app and generate a blank log file
touch /srv/apps/curate_uc/tmp/restart.txt
