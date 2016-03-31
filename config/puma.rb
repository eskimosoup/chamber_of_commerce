require "active_record"

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads(threads_count, threads_count)

directory '/home/chamber/current'

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{ app_dir }/tmp"

# Default to production
environment ENV['RAILS_ENV'] || 'production'

# Set up socket location
bind "unix://#{ app_dir }/tmp/chamber.sock"

# Logging
stdout_redirect "#{ app_dir }/log/puma.stdout.log", "#{ app_dir }/log/puma.stderr.log"

# Set master PID and state locations
pidfile "#{ tmp_dir }/pids/puma.pid"
daemonize true

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
