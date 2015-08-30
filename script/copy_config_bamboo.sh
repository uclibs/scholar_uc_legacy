#!/bin/bash

# Copy bamboo config files to proper locations

cp /srv/apps/curate_uc/config/database.yml.bamboo /srv/apps/curate_uc/config/database.yml
cp /srv/apps/curate_uc/config/doi.yml.bamboo /srv/apps/curate_uc/config/doi.yml
cp /srv/apps/curate_uc/config/fedora.yml.bamboo /srv/apps/curate_uc/config/fedora.yml
cp /srv/apps/curate_uc/config/solr.yml.bamboo /srv/apps/curate_uc/config/solr.yml
cp /srv/apps/curate_uc/config/authentication.yml.bamboo /srv/apps/curate_uc/config/authentication.yml
