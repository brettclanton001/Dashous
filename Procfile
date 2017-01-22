web: bundle exec puma -C config/puma.rb
worker: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 QUEUE=* bundle exec rake environment resque:work
scheduler: bundle exec rake environment resque:scheduler

