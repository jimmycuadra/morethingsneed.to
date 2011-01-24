default_environment['GEM_PATH'] = '/home/jimmycua/ruby/gems:/usr/lib/ruby/gems/1.8'

set :stages, %w(production staging)
set :default_stage, 'production'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :application, "morethingsneed"
set :user, "jimmycua"
set :domain, "morethingsneed.to"
set :repository,  "ssh://#{user}@#{domain}/home/#{user}/git/shared/mike/#{application}.git"
set :deploy_to, "/home/#{user}/public_html/#{application}"
default_run_options[:pty] = true

set :scm, :git

role :web, domain
role :app, domain
role :db, domain, :primary => true

# Site5 specifics
set :runner, nil
set :use_sudo, false
set :group_writable, false
set :keep_releases, 3

after 'deploy:update', 'deploy:update_dependencies'
after 'deploy:update', 'deploy:cleanup'

namespace :deploy do
  desc "Copies in .htaccess, links shared assets"
  task :update_dependencies, :roles => :app, :except => { :no_release => true } do
    run "cp #{shared_path}/htaccess #{release_path}/public/.htaccess"
    run "ln -nfs #{shared_path}/app_config.yml #{release_path}/config/app_config.yml"
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/googlehostedservice.html #{release_path}/public/googlehostedservice.html"
  end

  desc "Restarts the server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end
