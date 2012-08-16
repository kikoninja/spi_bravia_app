set :branch, 'master'
set :domain, "vmruby.invideous.local"
server domain, :app, :web
role :db, domain, :primary => true
