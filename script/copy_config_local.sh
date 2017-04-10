#!/bin/bash

# Copy sample config file to proper locations

cp config/database.yml.sample config/database.yml
cp config/doi.yml.sample config/doi.yml
cp config/fedora.yml.sample config/fedora.yml
cp config/solr.yml.sample config/solr.yml
cp config/initializers/curate_config.rb.sample config/initializers/curate_config.rb
cp config/authentication.yml.sample config/authentication.yml
cp config/initializers/devise.rb.sample config/initializers/devise.rb
