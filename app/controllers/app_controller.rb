require 'sinatra'
require 'sinatra/activerecord'
require_relative '../helpers/sessions_helper'
require 'sinatra/flash'
require 'sinatra/cookies'

get '/' do
  erb :"app_pages/home"
end

get '/search' do
  erb :"app_pages/search"
end
