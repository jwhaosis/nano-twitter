require 'byebug'

enable :sessions

helpers SessionsHelper

# go to sign up page
get '/user/register' do
  if logged_in?
    redirect "/"
  else
    erb :'/app_pages/signup'
  end
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

get '/login' do
  if logged_in?
    redirect '/'
  else
    erb :'/app_pages/login'
  end
end

# create new user
post '/login' do
  email = params[:session][:email].downcase
  user = User.exists?(email: email) ? User.find_by(email: email) : nil
  
  if user && user.authenticate(params[:session][:password])
    log_in(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect '/'
  else
    flash.now[:error] = 'Invalid email/password combination'
    redirect '/user/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# all the tweets of user_id: id
get '/user/:id' do
  @searched_user = User.find(params[:id])
  @tweets = Tweet.find(:id => :id)
  erb :"user_pages/user_tweets"
end

post '/user/:id/follow' do
  @user = User.where(id: session[:user_id]).first
  @user.change_follow_status :id
  redirect '/'
end

get '/user/:id/following' do
  @user = User.find(params[:id])
  @followings = @user.following
  byebug
  erb :"user_pages/user_following", :followings => @followings
end

get '/user/:id/followers' do
  @user = User.find(params[:id])
  @followers = @user.followers
  erb :"user_pages/user_followers", :followers => @followers
end


get '/user/:id/tweets' do
  erb :"user_pages/user_tweet", :user_id => :id
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :"user_pages/user", :user_id => :id
end

# ---- For the API ----- #

get '/api/v1/:apitoken/users/:id' do
  @users = User.find(params[:id])
end

get '/api/v1/:apitoken/users/:id/tweets' do
  @tweets = Tweet.find(:user_id => :id)
end
