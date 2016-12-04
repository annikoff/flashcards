#!/usr/bin/env bash

# Install rvm
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -L get.rvm.io | bash -s $1 #--ignore-dotfiles
echo 'source ~/.profile' >> /home/vagrant/.bash_profile
source ~/.profile

# Install Ruby
rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default

# Install Postgresql
sudo rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
sudo yum -y install postgresql95-server postgresql95 postgresql95-devel

# Initialize database
sudo /usr/pgsql-9.5/bin/postgresql95-setup initdb

# Use password authentication
sudo sed -Ei 's/(127.0.0.1\/32|::1\/128)(\s+)ident/\1\2md5/g' /var/lib/pgsql/9.5/data/pg_hba.conf

# Start PostgreSQL Server
sudo systemctl start postgresql-9.5
sudo systemctl enable postgresql-9.5

# Create user "vagrant" with password "vagrant"
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

# Install Node.js
sudo yum -y install epel-release
sudo yum -y install nodejs

# Copy database config
cp config/database.yml.example config/database.yml

# Install gems
export RAILS_ENV
gem install bundler
gem install pg -- --with-pg-config=/usr/pgsql-9.5/bin/pg_config
bundle install
bundle exec rake db:setup

# Run rails application
rackup
