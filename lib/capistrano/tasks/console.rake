# https://stackoverflow.com/questions/9569070/how-to-enter-rails-console-on-production-via-capistrano
# https://gist.github.com/joost/9343156
namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'

  task :console do
    server = roles(:app)[ARGV[2].to_i]


    on roles(:app) do
      bundle_exec = "bundle exec rails console -e #{fetch(:rails_env)}"
      ssh = ["ssh #{server.user}@#{server.hostname}"]
      ssh << "-t '"
      ssh << "cd #{current_path}"
      ssh << '&&'
      ssh << fetch(:rbenv_prefix)
      ssh << bundle_exec
      ssh << "'"
      puts "#{bundle_exec} on #{server.user}@#{server.hostname}"
      exec ssh.join(' ')
    end
  end
end
