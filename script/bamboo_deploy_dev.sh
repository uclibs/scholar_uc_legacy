#!/bin/bash

# This is a copy of the tasks performed by Bamboo to deploy to scholar-dev.uc.edu

echo "The deploy to https://scholar-dev.uc.edu has started" | mail -s 'Scholar@UC deploy started (scholar-dev)' scholar@uc.edu
rm -rf /srv/apps/curate_uc/*
cp -R /srv/apps/curate/curate_uc-STAGE/* /srv/apps/curate_uc
cd /srv/apps/curate_uc
chmod +x /srv/apps/curate_uc/script/*.sh
/srv/apps/curate_uc/script/kill_resque_pool.sh
export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin
gem install --user-install bundler
/srv/apps/curate_uc/script/copy_config_bamboo.sh
bundle install --path vendor/bundle
bundle exec rake db:migrate
mkdir -p /srv/apps/curate_uc/tmp
touch /srv/apps/curate_uc/tmp/restart.txt
export PATH=$PATH:/opt/fits/fits-0.6.2/
/usr/bin/crontab /srv/apps/curate_uc/script/crontab_dev
/srv/apps/curate_uc/script/restart_resque.sh development
echo "The deploy to https://scholar-dev.uc.edu is finished" | mail -s 'Scholar@UC deploy finished (scholar-dev)' scholar@uc.edu
