require 'sinatra'
require './paths/app_paths.rb'
require './paths/tweet_paths.rb'
require './paths/user_paths.rb'

set :views, Proc.new { File.join(root, "app/views") }
