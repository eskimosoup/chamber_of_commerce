# http://www.talkingquickly.co.uk/2013/12/tailing-log-files-with-capistrano-3/
namespace :logs do
  desc 'tail rails logs'
  task :env do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end

  desc 'tail custom log'
  task :file do
    on roles(:app) do
      execute "ls #{shared_path}/log/*.log"
      ask(:filename, 'without .log')
      execute "tail -f -n +1 #{shared_path}/log/#{fetch(:filename)}.log"
    end
  end
end
