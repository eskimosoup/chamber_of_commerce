# frozen_string_literal: true

# https://gist.github.com/twetzel/66de336327f79beac0e0#gistcomment-1787791
# https://gist.github.com/dsandstrom/4e6d118b4ca22e0fc7d40d40c5a8f22d
# https://gist.github.com/Mavvie/90bc453d29c46cfd3db0105d0f7d4c9b
# https://stackoverflow.com/a/45236293
# https://github.com/capistrano/rails/blob/660e9ba03d161b93d5fb00537de1a8158bb9a44d/lib/capistrano/tasks/assets.rake#L122
# https://github.com/stve/capistrano-local-precompile/blob/master/lib/capistrano/local_precompile.rb

Rake::Task['deploy:compile_assets'].clear
Rake::Task['deploy:set_linked_dirs'].clear

namespace :load do
  task :defaults do
    set :rsync, 'rsync --archive --compress --delete'
    set :jpegoptim_flags, '--max=90 --strip-all --all-progressive'
    set :optipng_flags, '-quiet -strip all -o2'
    set :assets_cache, 'tmp/assets_cache'
    set :assets_activity, [fetch(:assets_cache), 'activity.txt'].join('/')
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
    invoke 'deploy:assets:cache'
    invoke 'deploy:assets:exec'
    invoke 'deploy:assets:compress_images'
    invoke 'deploy:assets:sync'
    invoke 'deploy:assets:cleanup'
    invoke 'deploy:assets:backup_manifest'
  end

  namespace :assets do
    desc 'Check if asset exists from previous precompilation'
    task :cache do
      if File.directory?(fetch(:assets_cache)) && File.exist?(fetch(:assets_activity))
        directories.each do |_local, remote|
          next unless File.directory?([fetch(:assets_cache), remote.gsub('public/', '')].join('/'))

          run_locally do
            execute "mv #{[fetch(:assets_cache), remote.gsub('public/', '')].join('/')} #{remote}"
          end
        end

        # if modified outside of last 1440 minutes (24hr), there is no reliable
        # way to remove old pack files, so delete assets entirely and rebuild
        unless File.mtime(fetch(:assets_activity)) > (Time.now - (60 * 1440))
          run_locally do
            execute "bundle exec rake assets:clobber RAILS_ENV=#{fetch(:stage)}"
          end
        end
      end
    end

    desc 'Precompile'
    task :exec do
      run_locally do
        execute "bundle exec rake assets:precompile RAILS_ENV=#{fetch(:stage)}"
      end
    end

    task :compress_images do
      run_locally do
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
      unless File.directory?(fetch(:assets_cache))
        run_locally do
          execute "mkdir -p #{fetch(:assets_cache)}/"
        end
      end

      directories.each do |local, remote|
        next unless File.directory?(local)

        run_locally do
          execute "mv #{remote} #{fetch(:assets_cache)}/"
        end
      end

      run_locally do
        execute "touch #{fetch(:assets_cache)}/activity.txt"
      end
    end
  end
end
