require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "azurie"
set :repository,  "git://github.com/hemantic/azurie.git"
set :deploy_to, "/home/web/www/#{application}"
set :scm, :git
set :user, "web"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system

role :web, "50.56.201.43"                          # Your HTTP server, Apache/etc
role :app, "50.56.201.43"                          # This may be the same as your `Web` server
role :db,  "50.56.201.43", :primary => true # This is where Rails migrations will run
role :db,  "50.56.201.43"

set :default_environment, {'PATH' => "/sbin:$PATH"}
default_run_options[:pty] = true
set :sudo, 'rvmsudo'
set :foreman_concurrency, "\"listener=1,janitor=1,sync=1\""
require 'foreman/capistrano'

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Run rake db:migrate'
  task :apply_migrations, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:migrate"
  end

  desc 'Run rake db:create'
  task :create_db, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:create"
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:migrate"
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:seed"
  end

  desc 'Run rake assets:precompile'
  task :precompile_assets do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end
end

after 'deploy:setup', 'deploy:update_code'
after 'deploy:setup', 'deploy:create_symlink'
after 'deploy:setup', 'deploy:create_db'
after 'deploy:setup', 'deploy:precompile_assets'
after "deploy:setup", "foreman:export"
after "deploy:setup", "foreman:restart"

after 'deploy:update', 'deploy:apply_migrations'
after 'deploy:update', 'deploy:precompile_assets'
after 'deploy', 'deploy:cleanup'
after "deploy", "foreman:export"
after "deploy", "foreman:restart"

desc 'Show production web server logs. Last 500 lines per server by default.'
task :logs, :roles => :web do
    run "tail -n500 #{current_path}/log/production.log"
end
