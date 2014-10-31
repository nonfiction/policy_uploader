require 'sequel'

if ENV['RACK_ENV'] == 'production'
  db_url = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/policy_uploader')
  DB = Sequel.connect(db_url.to_s)
elsif ENV['RACK_ENV'] == 'test'
  DB = Sequel.connect('sqlite://db/test.db')
else
  DB = Sequel.connect('sqlite://db/development.db')
end
