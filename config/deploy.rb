lock '~> 3.19.1'

set :application, 'myclients365-preview'
set :repo_url, 'git@github.com:melnikovsansan/myclients-preview'
set :stages, %w(staging)

set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"

set :delayed_job_workers, 2
set :delayed_job_prefix, :jobs
set :delayed_job_queues, %w[default]

set :delayed_job_pools, {
  default: 1,
}

set :delayed_job_roles, [:app, :background]

set :rbenv_ruby, File.read('.ruby-version').strip

append :linked_dirs, 'log', 'storage', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'
append :linked_files, '.env', 'config/puma.rb'

before 'puma:smart_restart', 'puma:install'

after 'deploy:published', 'restart' do
  invoke 'delayed_job:restart'
end
