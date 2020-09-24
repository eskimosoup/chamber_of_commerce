# frozen_string_literal: true

Rake::Task['deploy:compile_assets'].clear
Rake::Task['deploy:set_linked_dirs'].clear

namespace :load do
  task :defaults do
    set :rsync, 'rsync --archive --compress --delete'
    set :jpegoptim_flags, '--max=90 --strip-all --all-progressive'
    set :optipng_flags, '-quiet -strip all -o2'
  end
end

namespace :deploy do
  directories = [
    ['./public/assets/', 'public/assets/'],
    ['./public/packs/', 'public/packs/']
  ]

  desc 'Compile assets'
  task compile_assets: [:set_rails_env] do
    # invoke 'deploy:assets:precompile'
    invoke 'deploy:assets:exec'
    # invoke 'deploy:assets:compress_images'
    invoke 'deploy:assets:sync'
    invoke 'deploy:assets:cleanup'
    invoke 'deploy:assets:backup_manifest'
  end

  namespace :assets do
    desc 'Precompile'
    task :exec do
      run_locally do
        with rails_env: fetch(:stage) do
          execute "bundle exec rake assets:clobber assets:precompile RAILS_ENV=#{fetch(:stage)}"
        end
      end
    end

    task :compress_images do
      run_locally do
        next if assets_cache_recent?

        jpegoptim = system('which jpegoptim')
        optipng = system('which optipng')

        directories.each do |local, _remote|
          next unless File.directory?(local)

          if jpegoptim
            execute "find #{local} -type f \\( -name '*.JPG' -or -name '*.jpg' \\) -exec jpegoptim #{fetch(:jpegoptim_flags)} {} \\;"
          end
          if optipng
            execute "find #{local} -type f \\( -name '*.PNG' -or -name '*.png' \\) -exec optipng #{fetch(:optipng_flags)} {} \\;"
          end
        end
      end
    end

    task :sync do
      on roles(fetch(:assets_roles)), in: :parallel do |server|
        path = "#{server.user}@#{server.hostname}:#{release_path}/"
        directories.each do |local, remote|
          next unless File.directory?(local)

          run_locally { execute "#{fetch(:rsync)} #{local} #{path}#{remote}" }
        end
      end
    end

    task :cleanup do
      run_locally do
        execute "bundle exec rake assets:clobber RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end
end
