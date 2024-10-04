# myclients365-preview-app-1-unoserver

server '46.101.105.205', user: 'deploy', roles: %w[app db web]

set :stage, :staging
set :branch, :staging
