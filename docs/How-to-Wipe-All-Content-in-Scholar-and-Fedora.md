### Purge the Fedora repository
1. Log into the appropriate Fedora server (dev or QA - **DO NOT WIPE PRODUCTION**)

1. Stop Tomcat:<br />`sudo service tomcat stop`

1. Delete content from the datastreamStore directory:<br />`sudo rm -rf /usr/local/fedora/data/datastreamStore/*`

1. Delete content from the objectStore directory:<br />`sudo rm -rf /usr/local/fedora/data/objectStore/*`

1. Wipe the Fedora MySQL database:<br />`/home/hortongn/fedora_mysql_wipe.sh`

1. Switch to the Tomcat user:<br />`sudo su - tomcat`

1. Set the Fedora and Tomcat environment variables:<br />`export FEDORA_HOME=/usr/local/fedora`<br />`export CATALINA_HOME=/usr/local/tomcat`

1. Run the fedora-rebuild script **twice** (choose option #1 the first time and option #2 the second time):<br />`/usr/local/fedora/server/bin/fedora-rebuild.sh`

1. Exit the Tomcat user:<br />`exit`

1. Start Tomcat:<br />`sudo service tomcat start`

### Clear the Solr index

1. Log into the Solr server (dev or QA)

1. Clear the Solr index:<br />`curl http://localhost:8080/solr/repository/update?commit=true -H "Content-Type: text/xml" --data-binary '<delete><query>*:*</query></delete>'`

### Purge the app's rails database
1. Log into the appropriate web server (dev or QA)

1. Switch to the curate user:<br />`sudo su - curate`

1. Change to the app directory:<br />`cd /srv/apps/curate_uc`

1. Set the environment for bundler:<br />`export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin`

1. Reset and migrate the database:<br />`bundle exec rake db:drop RAILS_ENV=development` (Use `production` for QA/prodution)<br />`bundle exec rake db:create RAILS_ENV=development` (Use `production` for QA/prodution)<br />`bundle exec rake db:migrate RAILS_ENV=development` (Use `production` for QA/prodution)
    * Alternative in MySQL:<br />`drop database curate;`<br />`create database curate;`

1. Restart the app (run this command on each of the load balanced servers):<br />`touch /srv/apps/curate_uc/tmp/restart.txt`