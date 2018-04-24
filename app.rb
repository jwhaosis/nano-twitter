require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/cookies'
require 'redis'
require 'dotenv'
require 'eventmachine'
require 'em-http'
require 'faker'
require 'require_all'
require_relative 'loaderio.rb'
require_all 'app/helpers'
require './app/controllers/app_controller'
require_all 'app'

Dotenv.load
$redis = Redis.new(:host => ENV["REDIS_URI"], :port => 10619, :password => ENV["REDIS_PASS"])
set :views, Proc.new { File.join(root, "app/views") }
