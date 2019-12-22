#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# get the DB in ship shape
bundle exec rails db:create db:migrate db:test:prepare

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
