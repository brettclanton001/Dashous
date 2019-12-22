#!/bin/bash
set -e

# get the DB in ship shape
bundle exec rails db:create db:migrate db:test:prepare

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
