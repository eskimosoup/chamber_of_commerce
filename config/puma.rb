workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads(threads_count, threads_count)

directory '/home/chamber/current'

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{ app_dir }/tmp"

# Default to production
rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

# Set up socket location
bind "unix://#{ app_dir }/tmp/chamber.sock"

# Logging
stdout_redirect "#{ app_dir }/log/puma.stdout.log", "#{ app_dir }/log/puma.stderr.log"

# Set master PID and state locations
pidfile "#{ tmp_dir }/pids/puma.pid"
daemonize true

on_worker_boot do
  require "active_record"
  require "friendly_id"
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
  end
end

