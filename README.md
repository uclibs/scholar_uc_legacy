## Installing and starting the CurateUC application
1. Clone this repository: `git clone https://github.com/uclibs/curate_uc.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Run bundler: `bundle install`
1. Install hydra-jetty: `rails g hydra:jetty`
1. Start hydra-jetty: `bundle exec rake jetty:start`
1. Run the database migrations: `bundle exec rake db:migrate`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)

## The information below relates to the CurateUC application installed on the UC Libraries sandbox server (Larry).

## UC Libraries Sandbox (Larry) Information

* URL: http://larry.libraries.uc.edu:3001 
* Directory: /opt/rails-apps/curate_app 
* WEBrick port: 3001 
* jetty port: 4001

## Starting the Redis server and rescue workers on Larry
1. redis-server /etc/conf/redis.conf
1. count=4 QUEUE=* rake environment resque:work

## Starting the CurateUC application on Larry

1. cd /opt/rails-apps/curate_app
1. sudo -u webapp -s
1. source ~/.rvm/scripts/rvm
1. rake jetty:start
1. rails server -p 3001 -d
1. exit

## Stopping the CurateUC application on Larry

1. cd /opt/rails-apps/curate_app
1. sudo -u webapp -s
1. ps aux | grep 3001
1. kill <pid>
1. rake jetty:stop
1. ps aux | grep curate
1. kill <pid>
1. exit

## Stopping the Redis server on Larry
* redis-cli shutdown

# Project Hydra
This software has been developed by and is brought to you by the Hydra community.  Learn more at the
[Project Hydra website](http://projecthydra.org)

![Project Hydra Logo](https://github.com/uvalib/libra-oa/blob/a6564a9e5c13b7873dc883367f5e307bf715d6cf/public/images/powered_by_hydra.png?raw=true)
