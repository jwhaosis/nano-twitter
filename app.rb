require 'sinatra'
require './app/controllers/app_controller'
require './app/controllers/tweets_controller'
require './app/controllers/users_controller'
require './app/controllers/test_controller'
require_relative './app/models/user'
require_relative './app/models/tweet'
require_relative './app/models/follower'

set :views, Proc.new { File.join(root, "app/views") }
