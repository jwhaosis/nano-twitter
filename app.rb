require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/cookies'
require 'byebug'
#require 'newrelic_rpm'
require_relative './app/helpers/sessions_helper'
require_relative './app/controllers/app_controller'
require_relative './app/controllers/tweets_controller'
require_relative './app/controllers/users_controller'
require_relative './app/controllers/test_controller'
require_relative './app/models/user'
require_relative './app/models/tweet'
require_relative './app/models/follower'
require_relative './app/models/like'
require_relative './app/models/mention'
require_relative './app/models/tweettag'
require_relative './app/models/hashtag'

set :views, Proc.new { File.join(root, "app/views") }

before do
  #newrelic check
end

get '/loaderio-b2e4b797e349e5bb43997050b02a1255/' do
  "loaderio-b2e4b797e349e5bb43997050b02a1255"
end

get '/loaderio-c205f3ea872086526ce419d06dc04ae9/' do
  "loaderio-c205f3ea872086526ce419d06dc04ae9"
end

get '/loaderio-abf0c3b8e0a97d274c430526ca889d56/' do
  "loaderio-abf0c3b8e0a97d274c430526ca889d56"
end
