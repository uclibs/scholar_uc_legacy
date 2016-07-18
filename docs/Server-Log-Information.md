#### Web servers (libhydpwl1, libhydpwl2, libhydqwl1, libhydqwl2, libhyddwl2)
* Apache logs
    * Read access for curate user only
    * All logs auto-rotate weekly
    * Only most recent month is kept
    * `/var/log/httpd/scholar.uc.edu_access.log`
        * no tracking data
        * no useful data
    * `/var/log/httpd/ssl-scholar.uc.edu_access_ssl.log`
        * contains user IP addresses
        * contains logs of Apache requests
    * `/var/log/httpd/ssl-scholar.uc.edu_error_ssl.log`
        * contains user IP addresses
        * contains logs of failed Apache requests
    * `/var/log/httpd/error_log`
        * no tracking data
        * appears to contain Resque pool error data
    * `/var/log/httpd/native.log` (Shibboleth)
        * no tracking data
        * no useful data
* Rails app logs
    * Separate logs are kept on each of the load-balanced web servers
    * A bash script (/srv/apps/curate_uc/scripts/rotate_log.sh) is used to move the log file to the /srv/apps/curate_uc-logs directory on the first of the month and during deployments.
    * `/srv/apps/curate_uc/log/development.log` (dev server)
    * `/srv/apps/curate_uc/log/production.log` (production and QA servers)
        * Contains all of the actions taken by the app.  Can be useful for tracking down bugs in the app or figuring out why the site is down or misbehaving.
        * File sizes get very large vary quickly
        * no tracking data


#### Fedora servers (libhydpfl1, libhydqfl1, libhyddal1)
* Tomcat logs
    * None of the Tomcat logs are automatically rotated.
    * None of the Tomcat logs contain tracking data.
    * `/usr/local/tomcat/logs/catalina.<date>.log`
        * Contains logs about Tomcat itself (startup, shutdown, etc.)
        * File sizes are very small.
        * No tracking data
    * `/usr/local/tomcat/logs/localhost.<date>.log`
        * Logs errors and other details for Fedora
        * These log files can grow very large
    * `/usr/local/tomcat/logs/localhost_access_log.<date>.txt`
        * Logs the fetching and adding of objects to Fedora
        * This log file grows rather slowly
* Fedora
    * `/usr/local/fedora/server/logs/fedora.log`
        * Logs the fetching and adding of objects to Fedora
        * This log file grows very slowly
        * No tracking data

#### Solr servers (libhydpsl1, libhydqsl1, libhyddal1)
* Tomcat logs
    * None of the Tomcat logs are automatically rotated.
    * None of the Tomcat logs contain tracking data.
    * `/usr/local/tomcat/logs/catalina.<date>.log`
        * Contains logs about Tomcat itself (startup, shutdown, etc.)
        * File sizes are very small.
        * No tracking data
    * `/usr/local/tomcat/logs/localhost.<date>.log`
        * Logs errors and other details for Fedora
        * These files tend to stay small
    * `/usr/local/tomcat/logs/localhost_access_log.<date>.txt`
        * Logs Solr queries
        * This log file grows rather slowly
