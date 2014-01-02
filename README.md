## Application Information

* URL: http://larry.libraries.uc.edu:3001 
* Directory: /opt/rails-apps/curate_app 
* WEBrick port: 3001 
* jetty port: 4001

## Starting the Redis server and rescue workers
1. redis-server /etc/conf/redis.conf
1. count=4 QUEUE=* rake environment resque:work

## Starting Curate

1. cd /opt/rails-apps/curate_app
1. sudo -u webapp -s
1. source ~/.rvm/scripts/rvm
1. rake jetty:start
1. rails server -p 3001 -d
1. exit

## Stopping Curate

1. cd /opt/rails-apps/curate_app
1. sudo -u webapp -s
1. ps aux | grep 3001
1. kill <pid>
1. rake jetty:stop
1. ps aux | grep curate
1. kill <pid>
1. exit

## Stopping the Redis server
* redis-cli shutdown
