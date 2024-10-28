#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean assets
bundle exec rake assets:clean

# Build assets
bundle exec rake assets:precompile

# Run migrations
bundle exec rake db:migrate