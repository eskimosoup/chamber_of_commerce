# frozen_string_literal: true

# Send HEAD request to host to pre-load app for quick visiting
namespace :host do
  task :ping do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'ping_host:request'
        end
      end
    end
  end

  task :clear_cache do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'tmp:cache:clear'
        end
      end
    end
  end
end

# Update node_modules to reflect compiled assets
namespace :yarn do
  task :integrity do
    next unless File.directory?('node_modules')

    integrity = `yarn check --integrity`
    next if integrity.include?('success')

    run_locally do
      execute 'yarn install'
    end
  end
end

after 'deploy:log_revision', 'host:ping'
after 'host:ping', 'yarn:integrity'
