#### Log in to the production Fedora server and change to the log directory
1. `ssh vbbssh.ad.uc.edu`
1. `ssh libhydpfl1.private`
1. `sudo su - tomcat`
1. `cd /usr/local/tomcat/logs`

#### Compress the localhost logs (replace the dates with the month you want to compress)
1. `tar -czf localhost.2015-05.tar.gz localhost.2015-05-*`
1. `rm localhost.2015-05-*`

#### Compress the localhost_access logs (replace the dates with the month you want to compress)
1. `tar -czf localhost_access_log.2015-05.tar.gz localhost_access_log.2015-05-*`
1. `rm localhost_access_log.2015-05-*`