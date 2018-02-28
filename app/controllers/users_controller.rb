require 'sinatra'
require_relative '../models/user'
require 'byebug'
require_relative '../helpers/sessions_helper'
require 'sinatra/flash'

helpers SessionsHelper

# go to sign up page
get '/user/register' do
  erb :'/app_pages/signup'
end

# create new user
post '/user/register' do
  @user = User.new(params[:user])

  if @user.save
    log_in @user
    redirect '/'
  else
    redirect '/user/register'
  end
end

get '/user/login' do
  if logged_in?
    redirect '/user_pages/user'
  else
    redirect '/app_pages/login'
  end
end

# create new user
post '/user/login' do
  email = params[:session][:email].downcase
  user = User.exists?(email: email) ? User.find_by(email: email) : nil
  if user && user.authenticate(params[:session][:password])
    log_in(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    erb :"/user_pages/self"
  else
    flash.now[:error] = 'Invalid email/password combination'
    erb :"/app_pages/login"
  end
end

get '/user' do
  erb :"user_pages/self"
end

post '/user/:id/follow' do

end

get '/user/:id/following' do
  erb :"user_pages/user_following", :user_id => :id
end

get '/user/:id/followers' do
  erb :"user_pages/user_followers", :user_id => :id
end


get '/user/:id/tweets' do
  erb :"user_pages/user_tweet", :user_id => :id
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :"user_pages/user", :user_id => :id
end