# frozen_string_literal: true

namespace :deploy do
  desc 'Configure master.key'

  task :master_key do
    on roles(:all) do |_host|
      ['master.key', 'credentials.yml.enc'].each do |file|
        local_file = "config/#{file}"
        remote_file = "#{shared_path}/config/#{file}"
        next unless File.exist?(local_file)
        upload! local_file, remote_file
      end
    end
  end

  before 'deploy:check:linked_files', 'deploy:master_key'
end
