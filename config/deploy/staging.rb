# myclients365-preview.ergoserv.dev

server '46.101.214.138', user: 'deploy', roles: %w[app db web]

set :stage, :staging
set :branch, :capistrano_deploy
