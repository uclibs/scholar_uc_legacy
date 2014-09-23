# Scholar@UC

## Installing and starting the Scholar@UC application
1. Clone this repository: `git clone https://github.com/uclibs/curate_uc.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Run bundler: `bundle install`
1. Install hydra-jetty: `rails g hydra:jetty`
1. Start hydra-jetty: `bundle exec rake jetty:start`
1. Run the database migrations: `bundle exec rake db:migrate`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)

# Project Hydra
This software has been developed by and is brought to you by the Hydra community.  Learn more at the
[Project Hydra website](http://projecthydra.org)

![Project Hydra Logo](https://github.com/uvalib/libra-oa/blob/a6564a9e5c13b7873dc883367f5e307bf715d6cf/public/images/powered_by_hydra.png?raw=true)
