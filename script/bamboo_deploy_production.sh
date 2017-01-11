#!/bin/bash

# This is a copy of the tasks performed by Bamboo to deploy to scholar.uc.edu

echo "The deploy to Scholar@UC PRODUCTION server #1 has started" | mail -s 'Scholar@UC deploy started (scholar #1)' scholar@uc.edu

export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin
export PATH=$PATH:/opt/fits/fits-0.6.2/

# Set up staging directory
cd /srv/apps/curate/curate_uc-STAGE
chmod +x /srv/apps/curate/curate_uc-STAGE/script/*.sh
/srv/apps/curate/curate_uc-STAGE/script/copy_config_bamboo.sh

# Enable ClamAV gem
sed -i 's/#gem "clamav"/gem "clamav"/' /srv/apps/curate/curate_uc-STAGE/Gemfile

# Bundle and run migrations
gem install --user-install bundler
bundle install --path vendor/bundle
bundle exec rake db:migrate RAILS_ENV=production

# Stop background workers
/srv/apps/curate_uc/script/kill_resque_pool.sh

# Stop resque-scheduler
/srv/apps/curate_uc/script/kill_resque_scheduler.sh

# Archive and empty the application log
/srv/apps/curate_uc/script/rotate_log.sh

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
/srv/apps/curate_uc/script/restart_resque.sh production

# Restart the resque scheduler
/srv/apps/curate_uc/script/restart_resque_scheduler.sh production

# Update the cron jobs from the git repo
/usr/bin/crontab /srv/apps/curate_uc/script/crontab_production1

# Update the sitemap.xml
cd /srv/apps/curate_uc
bundle exec rake sitemap:refresh

# Reindex Solr
bundle exec rake solr:reindexnow

echo "The deploy to Scholar@UC PRODUCTION server #1 is finished" | mail -s 'Scholar@UC deploy finished (scholar #1)' scholar@uc.edu

