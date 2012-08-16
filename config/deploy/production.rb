set :branch, 'master'
set :domain, "178.79.178.237"
server domain, :app, :web
role :db, domain, :primary => true
