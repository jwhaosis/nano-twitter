require 'sinatra'
require './app/controllers/app_controller'
require './app/controllers/tweets_controller'
require './app/controllers/users_controller'

set :views, Proc.new { File.join(root, "app/views") }
