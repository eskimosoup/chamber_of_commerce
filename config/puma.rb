workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads(threads_count, threads_count)

preload_app!

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{ app_dir }/tmp"

# Default to production
environment ENV['RAILS_ENV'] || 'production'

# Set up socket location
bind "unix:///var/run/chamber.sock"

# Logging
stdout_redirect "#{ app_dir }/log/puma.stdout.log", "#{ app_dir }/log/puma.stderr.log"

# Set master PID and state locations
pidfile "#{ tmp_dir }/puma/pid"
state_path "#{ tmp_dir }/puma/state"
daemonize true

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

