=begin
require 'mongrel_cluster/recipes'
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
default_run_options[:pty] = true

set :scm, :git
set :application, "vce"
set :repository, "svn+ssh://draper.homelinux.com/home/draper/projects/vce"
role :app, "draper.homelinux.com"
role :web, "draper.homelinux.com"
role :db,  "draper.homelinux.com", :primary=>true
set :deploy_to, "/home/draper/vce_test"
set :mongrel_port, "3000"
set :scm_username, "draper"
set :scm_password, "mjisseXee2me"
set :password, "mjisseXee2me"
set :port_number, "3000"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
set :use_sudo, false
set :sudo, "sudo -p Password:"

	
 # task :start, :roles => :app do
    #run "cd #{deploy_to}/current; mongrel_rails start -e production -p #{port_number} -d"
  #end
  #task :stop, :roles => :app do
  #  #run "cd #{deploy_to}/current; mongrel_rails stop"
  #end
  task :update_remote_db, :roles => :app do
    #run "cd #{deploy_to}/current; mongrel_rails stop;"
    #run "cd #{deploy_to}/current/log; rm -rf mongrel.pid"
    run "cp #{deploy_to}/current/config/database.linux #{deploy_to}/current/config/database.yml"
    run "cd #{deploy_to}/current/; rake db:migrate  RAILS_ENV=production"
    #run "cd #{deploy_to}/current;  mongrel_rails start -e production -p #{port_number} -d"
    run "echo \"DB has been updated\""
  end

=end

default_run_options[:pty] = true

  set :application, "vce"

  # If you aren't deploying to /u/apps/#{application} on the target
  # servers (which is the default), you can specify the actual location
  # via the :deploy_to variable:
  set :deploy_to, "/var/www/vce_deploy"
 
  
  # If you aren't using Subversion to manage your source code, specify
  # your SCM below:
  set :scm, :git
  set :repository, "draper@draper.homelinux.com:/home/draper/git/vce.git"
  set :domain, "draper.homelinux.com"
  set :branch, "master"
  set :deploy_via, :remote_cache
  
  
  set :ssh_options, { :paranoid=>false}
  ssh_options[:forward_agent] = true
  
  #ssh_options[:forward_agent] = true
  
  
  set :runner, "draper"
  set :user, 'draper'
  set :scm_password, "mjisseXee2me"
  set :password, "mjisseXee2me"
  
  set :use_sudo, false
  
  
  
  role :app, domain
  role :web, domain
  role :db,  domain, :primary => true
  
  
  
  task :after_update_code, :roles => [:web, :db, :app] do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  end
  

  namespace :deploy do

    
    desc "Restarting mod_rails with restart.txt"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "touch #{current_path}/tmp/restart.txt"
    end

    [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
    end
  end

