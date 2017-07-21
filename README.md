# Scholar@UC

Scholar@UC is a digital repository that enables the University of Cincinnati community to share its research and scholarly work with a worldwide audience. Faculty and staff can use Scholar@UC to collect their work in one location and create a durable and citeable record of their papers, presentations, publications, datasets, or other scholarly creations.

Scholar@UC uses Samvera's [Hyrax gem](https://github.com/samvera/hyrax). The source for UC's Hyrax-based app can be found at https://github.com/uclibs/scholar_uc

The Univeristy of Cincinnati's implementation of Scholar@UC can be found at https://scholar.uc.edu.

## Installing the Scholar@UC application

### Option #1: Run Scholar@UC in your local Rails environment

Install system dependencies

***Our Hyrax 7.x based app requires the following software to work:

* Solr version >= 5.x (tested up to 6.2.0)
* Fedora Commons digital repository version >= 4.5.1 (tested up to 4.6.0)
* A SQL RDBMS (MySQL, PostgreSQL), though note that SQLite will be used by default if you're looking to get up and running quickly
  * libmysqlclient-dev (if running MySQL as RDBMS)
  * libsqlite3-dev (if running SQLite as RDBMS)
* Redis, a key-value store
* ImageMagick with JPEG-2000 support
* FITS version 0.8.x (0.8.5 is known to be good)
* LibreOffice

1. Clone this repository: `git clone https://github.com/uclibs/scholar_uc.git ./path/to/local`
    * **Note:** Solr will not run properly if there are spaces in any of the directory names above it <br />(e.g. /user/my apps/scholar_uc/) 
1. Change to the application's directory: e.g. `cd ./path/to/local`  
1. Make sure you are on the develop branch: `git checkout develop`
1. Copy the sample files: `script/copy_config_local.sh`
1. Install bundler (if needed): `gem install bundler`
1. Run bundler: `bundle install`
1. Start fedora: ```fcrepo_wrapper -p 8984```
1. Start solr: ```solr_wrapper -d solr/config/ --collection_name hydra-development```
1. Start redis: ```redis-server```
1. Run the database migrations: `bundle exec rake db:migrate`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)
 
## Running the Tests
`bundle exec rake spec`

## Need Help?

Have a question or comment about Scholar@UC? Contact scholar@uc.edu.

## Application Status

[![Build Status](https://travis-ci.org/uclibs/scholar_uc.svg?branch=sandbox)](https://travis-ci.org/uclibs/scholar_uc)

# Project Samvera
This software has been developed by and is brought to you by the Samvera community. Learn more at the
[Samvera website](http://projecthydra.org)

![Samvera Logo](https://wiki.duraspace.org/download/thumbnails/87459292/samvera-fall-font2-200w.png?version=1&modificationDate=1498550535816&api=v2)
