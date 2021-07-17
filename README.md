# README

Accounting app Application

# Installation process

## Install ruby with rbenv

rbenv install 2.7.0
rbenv local 2.7.0

## Install packages
sudo apt-get install libsqlite3-dev libpq-dev nodejs 

## Install bundler
gem install bundler
bundle install

## Setup a database
rake db:create
rake db:migrate

## Run rails and have fun!

rails s
