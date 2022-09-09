# config valid for current version and patch releases of Capistrano
# lock "~> 3.14.0"

set :application, 'chamber_of_commerce'
set :client, 'chamber_of_commerce'
set :deploy_via, :remote_cache
set :default_stage, 'production'
set :deploy_user, 'capistrano'
set :rbenv_type, :user
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :rbenv_ruby, File.read('.ruby-version').strip
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
# set :ssh_options, forward_agent: true
set :repo_url, "git@github.com:eskimosoup/chamber_of_commerce.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/credentials.yml.enc', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, '.bundle', 'vendor/bundle', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/uploads', 'public/uploads', 'public/.well-known'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
