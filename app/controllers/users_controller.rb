require 'sinatra'
require_relative '../models/user'
require 'byebug'
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
    redirect '/'
  else
    erb :'/app_pages/login'
  end
end

# create new user
post '/user/login' do
  email = params[:sessions][:email].downcase
  user = User.exists?(email: email) ? User.find_by(email: email) : nil
  if user && user.authenticate(params[:sessions][:password])
    log_in(user)
    # params[:sessions][:remember_me] == '1' ? remember(user) : forget(user)
    redirect '/'
  else
    flash.now[:error] = 'Invalid email/password combination'
    redirect '/user/login'
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

# ---- For the API ----- #

get '/api/v1/{apitoken}/users/:id' do
  @users = Users.find(params[:id])
end

get '/api/v1/{apitoken}/users/:id/tweets' do
  @tweets = Tweets.find(:user_id => :id)
end

#post '/api/v1/:apitoken/users/create' do
#  user = Users.new
  #add info from apitoken here
#end
