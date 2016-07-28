# Scholar@UC

Scholar@UC is a digital repository that enables the University of Cincinnati community to share its research and scholarly work with a worldwide audience. Faculty and staff can use Scholar@UC to collect their work in one location and create a durable and citeable record of their papers, presentations, publications, datasets, or other scholarly creations.

Scholar@UC uses Project Hydra's [Curate gem](https://github.com/projecthydra-labs/curate).  UC's custom version of the Curate gem can be found at https://github.com/uclibs/curate_fork

The Univeristy of Cincinnati's implementation of Scholar@UC can be found at https://scholar.uc.edu.

## Installing the Scholar@UC application

### Option #1: Run Scholar@UC in a Vagrant virtual environment
1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. Clone this repository: `git clone https://github.com/uclibs/scholar_uc.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Provision and start the Vagrant machine: `vagrant up` (this will take a while)
1. Ssh to the virtual machine: `vagrant ssh`
1. Start the Redis server: `sudo service redis start`
1. Add FITS to the path: `export PATH=$PATH:/home/vagrant/fits-0.6.2/`
1. Change to the application directory: `cd /home/vagrant/sync`
1. Start Jetty: `bundle exec rake jetty:start`
1. Start the background workers: `count=4 QUEUE=* rake environment resque:work &`
1. Start the application: `bundle exec rails server`
1. On your host machine, open a browser and visit `http://localhost:3000`

### Option #2: Run Scholar@UC in your local Rails environment

Install system dependencies
* libmysqlclient-dev (if running MySQL as RDBMS)
* libsqlite3-dev (if running SQLite as RDBMS)
* libclamav-dev 
* libclamav6 
* clamav 
* clamav-base 
* clamav-daemon
* clamav-unofficial-sigs
* clamav-freshclam

1. Clone this repository: `git clone https://github.com/uclibs/scholar_uc.git ./path/to/local`
    * **Note:** Solr will not run properly if there are spaces in any of the directory names above it <br />(e.g. /user/my apps/scholar_uc/) 
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Copy the config sample files: `script/copy_config_local.sh`
1. If you are not using MySQL, comment out the `gem 'mysql2'` line in the Gemfile
1. Run bundler: `bundle install`
1. Install hydra-jetty: `rails g hydra:jetty`
1. Start hydra-jetty: `bundle exec rake jetty:start`
1. Run the database migrations: `bundle exec rake db:migrate`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)
 
## Running the Tests
`bundle exec rake spec`

## Need Help?

Have a question or comment about Scholar@UC?  Contact scholar@uc.edu.

## Known issues

* If a restricted/private file is added to a public work, the thumbnails associated with that file will are broken. This only impacts the development environment (testing and production are okay), and is believed to be related to exception raising/handling in the development environment. Because this does not impact production or testing, we've decided not to address this issue.

## Application Status

[![Build Status](https://travis-ci.org/uclibs/scholar_uc.svg?branch=sandbox)](https://travis-ci.org/uclibs/scholar_uc)

# Project Hydra
This software has been developed by and is brought to you by the Hydra community.  Learn more at the
[Project Hydra website](http://projecthydra.org)

![Project Hydra Logo](https://upload.wikimedia.org/wikipedia/en/8/82/Hydra_logo.png)
