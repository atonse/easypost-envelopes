default_run_options[:pty] = true
set :application,   'easypost.tonse.com'
set :domain,        'easypost.tonse.com'
set :server_domain, 'localopus.com'
set :repository,    'git@bitbucket.org:atonse/easypost-envelopes.git'
set :branch,        'master'
set :scm,           :git
set(:deploy_to)     { "/opt/apps/#{domain}" }
set(:current_path)  { "#{deploy_to}/current" }
set :runner,        'deployer'
set :use_sudo,      false

role(:web) { server_domain }                         # Your HTTP server, Apache/etc
role(:app) { server_domain }                         # This may be the same as your `Web` server
role(:db, :primary => true) { server_domain }        # This is where Rails migrations will run

require "bundler/capistrano"

######## Callbacks - No More Config ########
before 'deploy:update_code', 'deploy:tag'
after 'deploy:update_code', 'custom:bundle'

after 'deploy:symlink', 'deploy:cleanup'            # makes sure there's only 3 deployments, deletes the extras

namespace :custom do
  task :bundle do
    run "bundle install --gemfile #{current_path}/Gemfile --path #{deploy_to}/shared/vendor_bundle --deployment --without assets development test"
  end
end


namespace :deploy do
  task :tag do
    run_locally "git tag -f #{rails_env} && git push --tags"
  end

  task :precompile do
    run_locally "rm -rf public/assets/*"
    run_locally "bundle exec rake assets:precompile"
    run_locally "touch assets.tgz && rm assets.tgz"
    run_locally "tar zcvf assets.tgz public/assets/"
    run_locally "mv assets.tgz public/assets/"
  end

  task :upload_assets do
    run_locally "scp public/assets/assets.tgz #{server_domain}:#{current_path}/assets.tgz"
    run "cd #{current_path}; tar zxvf assets.tgz; rm assets.tgz"
  end

  task :cleanup_local do
    run_locally "rm -rf public/assets"
  end

  task :default do
    precompile
    update_code
    upload_assets
    stop
    start
    cleanup_local
  end

  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    run "rm -rf #{current_path} && git clone #{repository} #{current_path} && mkdir -p #{current_path}/tmp/pids"
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    is_tag = !`git tag -l '#{branch}'`.empty?

    checkout_head = "&& git reset --hard origin/#{branch}"

    command = "cd #{current_path} && git fetch origin && git checkout -- . && git clean -df && git checkout #{branch} && mkdir -p tmp/pids "
    command += checkout_head unless is_tag

    run command
  end

  task :symlink_private_directory do
    puts "symlinking private directory"
    run "ln -s #{deploy_to}/shared/private #{current_path}/private"
  end
end
# Custom Tasks


namespace :deploy do
  task :start do
    restart
  end

  task :stop do; end

  task :restart, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


