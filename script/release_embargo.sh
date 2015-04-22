#!/bin/bash

# Change and expired embargoed objects to open access
# Runs as a cron job daily just after midnight

export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin:/opt/fits/fits-0.6.2/    
cd /srv/apps/curate_uc
bundle exec rake embargomanager:release
