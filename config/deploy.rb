$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3'        # Or whatever env you want it to run in.
set :rvm_type, :user

# Bundler support
require 'bundler/capistrano'

set :application, "spi_bravia_app"
set :repository,  "ssh://gituser@gateway.invideous.com/storage/disk1/gituser/repositories/spi_bravia_app.git"

set :scm, :git

set :deploy_to, "/home/rails/apps/#{application}"

set :user, "rails"
set :domain, "vmruby.invideous.local"
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

default_run_options[:pty] = true

namespace :deploy do
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "precompile the assets"
  task :precompile_assets, :roles => :web, :except => { :no_release => true } do
    run "cd #{current_path}; rm -rf public/assets/*"
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end