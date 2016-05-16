#!/bin/bash

# This is a copy of the tasks performed by Bamboo to deploy to scholar-dev.uc.edu

echo "The deploy to Scholar@UC DEV has started" | mail -s 'Scholar@UC deploy started (scholar-dev)' scholar@uc.edu

export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin
export PATH=$PATH:/opt/fits/fits-0.6.2/

# Set up staging directory
cd /srv/apps/curate/curate_uc-STAGE
chmod +x /srv/apps/curate/curate_uc-STAGE/script/*.sh
/srv/apps/curate/curate_uc-STAGE/script/copy_config_bamboo.sh

# Set up temp directory
mkdir -p /srv/apps/curate/curate_uc-STAGE/tmp

# Bundle and run migrations
gem install --user-install bundler
bundle install --path vendor/bundle
bundle exec rake db:migrate

# Stop background workers
/srv/apps/curate_uc/script/kill_resque_pool.sh

# Move current app directory to "previous"
rm -rf /srv/apps/curate_uc_previous
mv /srv/apps/curate_uc /srv/apps/curate_uc_previous

# Move staging directory to current app directory
mv /srv/apps/curate/curate_uc-STAGE /srv/apps/curate_uc
mkdir /srv/apps/curate/curate_uc-STAGE

# Set the deploy date for the footer
/bin/date +"%m-%d-%Y %r" > /srv/apps/curate_uc/config/deploy_timestamp

# Restart the application
touch /srv/apps/curate_uc/tmp/restart.txt

# Restart the background workers
/srv/apps/curate_uc/script/restart_resque.sh development

# Update the cron jobs from the git repo
/usr/bin/crontab /srv/apps/curate_uc/script/crontab_dev

echo "The deploy to Scholar@UC DEV is finished" | mail -s 'Scholar@UC deploy finished (scholar-dev)' scholar@uc.edu

