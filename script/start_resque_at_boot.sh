#!/bin/bash
#
# Run this from /etc/rc.local at boot time
# ex. /srv/apps/curate_uc/script/start_resque_at_boot.sh curate

su $1 -c 'export PATH=$PATH:/opt/fits/fits-0.6.2/; source /usr/local/rvm/scripts/rvm; cd /srv/apps/curate_uc/; ./script/restart_resque.sh development'
