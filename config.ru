require "rubygems"
require "bundler/setup"
require "sinatra"
require "haml"
require "mongoid"
Dir["./models/*.rb"].each {|file| require file }
require "./app"

Mongoid.load!("./mongoid.yml")

set :run, false
set :raise_errors, true

run Sinatra::Application