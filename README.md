# Scholar@UC

Scholar@UC is a digital repository that enables the University of Cincinnati community to share its research and scholarly work with a worldwide audience. Faculty and staff can use Scholar@UC to collect their work in one location and create a durable and citeable record of their papers, presentations, publications, datasets, or other scholarly creations.

Scholar@UC uses Project Hydra's [Curate gem](https://github.com/projecthydra-labs/curate).  UC's custom version of the Curate gem can be found at https://github.com/uclibs/curate_fork

The Univeristy of Cincinnati's implementation of Scholar@UC can be found at https://scholar.uc.edu.

## Testing the Scholar@UC application
1. Clone this repository: `git clone https://github.com/uclibs/scholar_uc.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Run bundler: `bundle install`
1. Install hydra-jetty: `rails g hydra:jetty`
1. Start hydra-jetty: `bundle exec rake jetty:start`
1. Run the database migrations: `bundle exec rake db:migrate`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)
 
## Running the Tests
`bundle exec rake rspec`

## Need Help?

Have a question or comment about Scholar@UC?  Contact scholar@uc.edu.

## Application Status

[![Build Status](https://travis-ci.org/uclibs/scholar_uc.svg?branch=sandbox)](https://travis-ci.org/uclibs/scholar_uc)

# Project Hydra
This software has been developed by and is brought to you by the Hydra community.  Learn more at the
[Project Hydra website](http://projecthydra.org)

![Project Hydra Logo](https://github.com/uvalib/libra-oa/blob/a6564a9e5c13b7873dc883367f5e307bf715d6cf/public/images/powered_by_hydra.png?raw=true)
