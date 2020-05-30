# frozen_string_literal: true
 
namespace :uploads do
  desc 'Compress server uploads'
  task :compress do
    on roles :app do
      directory = "#{fetch(:deploy_to)}/shared/public/uploads"
 
      jpegoptim = system('which jpegoptim')
      optipng = system('which optipng')
 
      execute "find #{directory} -type f \( -name '*.JPG' -or -name '*.jpg' \) -exec jpegoptim -m70 --strip-all --all-progressive --force {} \\;" if jpegoptim
      execute "find #{directory} -type f \( -name '*.PNG' -or -name '*.png' \) -exec optipng -quiet -strip all -o7 {} \\;" if optipng
    end
  end
 
  task :download do
    on roles :app do |server|
      folders = [['./public/uploads/', '/public/uploads/']]
      remote_path = "#{server.user}@#{server.hostname}:#{shared_path}"
      run_locally do
        folders.each do |local, remote|
          execute "rsync -va --delete #{remote_path}#{remote} #{local}"
        end
      end
    end
  end
end
