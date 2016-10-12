#!/bin/sh

export SECRET_TOKEN=`openssl rand -hex 20`

bundle exec rake db:migrate

bundle exec "$@"
