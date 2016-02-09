#!/usr/bin/env bash

sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y git unzip redis ImageMagick clamav clamav-update clamav-devel mysql-devel java-1.7.0-openjdk-devel nodejs gcc bzip2 kernel-devel dkms

# Get clamav working
sudo sed -i '/^Example/d' /etc/freshclam.conf
sudo /usr/bin/freshclam

# Install RVM
su - vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
su - vagrant -c 'curl -L https://get.rvm.io | bash -s stable --ruby'
su - vagrant -c 'rvm 2.1.6 --install --default'

# Bundle install and download jetty
su - vagrant -c 'gem install bundler'
su - vagrant -c 'cd /home/vagrant/sync; ./script/copy_config_local.sh'
su - vagrant -c 'cd /home/vagrant/sync; bundle install'
su - vagrant -c 'cd /home/vagrant/sync; bundle exec rake jetty:clean'
su - vagrant -c 'cd /home/vagrant/sync; bundle exec rake db:migrate'

# Characterization
su - vagrant -c 'cd /home/vagrant && wget http://projects.iq.harvard.edu/files/fits/files/fits-0.6.2.zip'
su - vagrant -c 'cd /home/vagrant && unzip fits-0.6.2.zip'
su - vagrant -c 'chmod u+x /home/vagrant/fits-0.6.2/fits.sh'

echo "

Now do the following to start the application:

vagrant ssh
sudo service redis start
export PATH=\$PATH:/home/vagrant/fits-0.6.2/
cd /home/vagrant/sync
bundle exec rake jetty:start
count=4 QUEUE=* rake environment resque:work &
bundle exec rails server

Then go to http://localhost:3000 in your host browser to use the application.

"
