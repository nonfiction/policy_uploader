require 'rubygems'
require 'bundler/setup'

$stdout.sync = true

require File.expand_path '../app.rb', __FILE__

run Sinatra::Application
