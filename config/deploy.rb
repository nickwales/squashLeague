set :application, 'squashLeague'
set :repo_url, 'git@github.com:nickwales/squashLeague.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/usr/share/nginx/squashLeague'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app) do #, in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute 'cd /usr/share/nginx/squashLeague/current && bundle install --path ../shared/vendor/'
      execute 'cd /usr/share/nginx/squashLeague/current && bundle exec rake assets:precompile'
      execute '/etc/init.d/unicorn reload'
#      execute '/etc/init.d/nginx reload'      

    end
  end

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
  #    # Here we can do anything such as:
  #     within release_path do
  #      # execute :rake, 'assets:precompile'
  #       run 'bundle exec rake assets:precompile'
  #     end
  #  end
  #end

#  after :finishing, 'deploy:cleanup'

end


#namespace :deploy do
#  %w[start stop restart].each do |command|
#    desc "#{command} unicorn server"
#    task command, roles: :app, except: {no_release: true} do
#      run "/etc/init.d/#{application} #{command}"
#    end
#  end

  #task :setup_config, roles: :app do
  #  sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
  #  sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  #  run "mkdir -p #{shared_path}/config"
  #  put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
  #  puts "Now edit the config files in #{shared_path}."
  #end
  #after "deploy:setup", "deploy:setup_config"

  #task :symlink_config, roles: :app do
  #  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  #end
  #after "deploy:finalize_update", "deploy:symlink_config"
  #
  #desc "Make sure local git is in sync with remote."
  #task :check_revision, roles: :web do
  #  unless `git rev-parse HEAD` == `git rev-parse origin/master`
  #    puts "WARNING: HEAD is not the same as origin/master"
  #    puts "Run `git push` to sync changes."
  #    exit
  #  end
  #end
  #before "deploy", "deploy:check_revision"
#end
