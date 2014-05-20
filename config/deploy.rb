# Define the name of the application
set :application, 'CUC02_Website'

# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/WickedDevice/CUCO2_Website'
set :scm, :git
set :repo_url, 'https://github.com/WickedDevice/CUCO2_Website.git'

# Define where to put your application code
set :deploy_to, "/home/deployer/apps/CUCO2_Website"

set :pty, true

set :format, :pretty

# Set the post-deployment instructions here.
# Once the deployment is complete, Capistrano
# will begin performing them as described.
# To learn more about creating tasks,
# check out:
# http://capistranorb.com/

#namespace :deploy do
#
# desc 'Restart application'
#   task :restart, :roles => :web do
#     # Your restart mechanism here, for example:
#     # execute :touch, release_path.join('tmp/restart.txt')
#     run "touch #{ current_path }/tmp/restart.txt"
#     ### sudo "/etc/init.d/nginx restart" # => Probably don't need to restart nginx
#   end

#   after :publishing, :restart

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

#end
