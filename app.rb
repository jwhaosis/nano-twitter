require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/cookies'
require 'byebug'
#require 'newrelic_rpm'
require_relative 'loaderio.rb'
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
