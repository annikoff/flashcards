# Install rvm and Ruby 2.3.3
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm

rvm install 2.3.3
rvm use 2.3.3 --default

# Install Postgresql
sudo rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
sudo yum -y install postgresql95-server postgresql95 postgresql95-devel

# Initialize database
sudo /usr/pgsql-9.5/bin/postgresql95-setup initdb

# Start PostgreSQL Server
systemctl start postgresql-9.5
systemctl enable postgresql-9.5
#psql -c 'create database travis_ci_test;' -U postgres

# Install Node.js
sudo yum -y install epel-release
sudo yum -y install nodejs

cd /vagrant
cp config/database.yml.example config/database.yml
sudo chmod 777 /usr/local/rvm/ -R
gem install bundler
gem install pg -- --with-pg-config=/usr/pgsql-9.5/bin/pg_config
bundle install
bundle exec rake db:setup
