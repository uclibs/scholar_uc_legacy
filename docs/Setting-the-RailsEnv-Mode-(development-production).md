Edit the Apache config files to set the mode Passenger runs in.

1. Log into the appropriate web server
1. Set the Passenger mode in the 25-scholar config file<br />`sudo vim /etc/httpd/conf.d/25-scholar-<server>-uc.edu.conf`
    1. Find the line that begins with *RailsEnv* and set it to `RailsEnv development` or `RailsEnv production`
1. Repeat step 2 for `/etc/httpd/conf.d/25-ssl-<server>-uc.edu.conf`
1. Restart Apache<br />`sudo service httpd restart`
1. Restart the application<br />`touch /srv/apps/curate_uc/tmp/restart.txt`

Change the mode that the background workers run in

1. Stop the existing workers<br />`/srv/apps/curate_uc/script/kill_resque_pool.sh`
1. Start the workers<br />`/srv/apps/curate_uc/script/restart_resque.sh development` or `/srv/apps/curate_uc/script/restart_resque.sh production`

***NOTE: if you are making these changes on the QA or production web servers, repeat these steps on the second load-balanced server***