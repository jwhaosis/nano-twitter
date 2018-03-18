require 'sinatra'
require 'sinatra/activerecord'
require_relative '../helpers/sessions_helper'
require 'sinatra/flash'
require 'sinatra/cookies'
enable :sessions

helpers SessionsHelper

get '/' do
  @tweets = logged_in? ? current_user.following_tweets.first(50) : Tweet.first(50)
  erb :"app_pages/home"
end

get '/search' do
  erb :"app_pages/search"
end
