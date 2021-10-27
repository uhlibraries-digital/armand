#!/bin/sh

set -e

rm -f /armand-app/tmp/pids/server.pid

bundle exec sidekiq -q default & >> /dev/null 2>&1
bundle exec rails s -p 3000 -b 0.0.0.0
