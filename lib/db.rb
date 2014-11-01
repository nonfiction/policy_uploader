require 'sequel'

if ENV['RACK_ENV'] == 'production'
  db_url = ENV['DATABASE_URL']
elsif ENV['RACK_ENV'] == 'test'
  db_url = 'postgres://localhost/policy_uploader_development'
else
  db_url = 'postgres://localhost/policy_uploader_test'
end

DB = Sequel.connect(URI.parse(db_url).to_s)

DB.extension(:connection_validator)

DB.pool.connection_validation_timeout = -1
