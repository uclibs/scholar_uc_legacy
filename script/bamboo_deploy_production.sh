#!/bin/bash

# This is a copy of the tasks performed by Bamboo to deploy to scholar.uc.edu

echo "The deploy to https://scholar.uc.edu has started" | mail -s 'Scholar@UC deploy started (scholar.uc.edu)' scholar@uc.edu
/srv/apps/curate_uc/script/rotate_log.sh
rm -rf /srv/apps/curate_uc/*
cp -R /srv/apps/curate/curate_uc-STAGE/* /srv/apps/curate_uc
cd /srv/apps/curate_uc
chmod +x /srv/apps/curate_uc/script/*.sh
/srv/apps/curate_uc/script/kill_resque_pool.sh
cp /srv/apps/curate_uc/public/robots.prod.txt /srv/apps/curate_uc/public/robots.txt
export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin:/opt/fits/fits-0.6.2/
gem install --user-install bundler
/srv/apps/curate_uc/script/copy_config_bamboo.sh
bundle install --path vendor/bundle
bundle exec rake db:migrate RAILS_ENV=production
mkdir -p /srv/apps/curate_uc/tmp
touch /srv/apps/curate_uc/tmp/restart.txt
/usr/bin/crontab /srv/apps/curate_uc/script/crontab_production1
/srv/apps/curate_uc/script/restart_resque.sh production
/bin/date +"%m-%d-%Y %r" > /srv/apps/curate_uc/config/deploy_timestamp
echo "The deploy to https://scholar.uc.edu is finished" | mail -s 'Scholar@UC deploy finished (scholar.uc.edu)' scholar@uc.edu
