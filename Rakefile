require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

task :migrate do
  require './lib/db'
  Sequel.extension :migration
  Sequel::Migrator.run(DB, './db/migrate', :use_transactions=>true)
end
