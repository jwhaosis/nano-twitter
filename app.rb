require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/cookies'

require_relative './app/controllers/app_controller'
require_relative './app/controllers/tweets_controller'
require_relative './app/controllers/users_controller'
require_relative './app/controllers/test_controller'
require_relative './app/models/user'
require_relative './app/models/tweet'
require_relative './app/models/follower'


set :views, Proc.new { File.join(root, "app/views") }

get '/loaderio-b2e4b797e349e5bb43997050b02a1255/' do
  "loaderio-b2e4b797e349e5bb43997050b02a1255"
end
