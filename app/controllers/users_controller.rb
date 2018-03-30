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
  @tweets = @searched_user.tweets.order(created_at: :desc)
  erb :"user_pages/user_tweets"
end

post '/user/:id/follow' do
  to_follow_id = User.find(params[:id])
  follow to_follow_id.id
  redirect "/user/#{params[:id]}"
end

post '/user/:id/unfollow' do
  to_unfollow_id = User.find(params[:id])
  unfollow to_unfollow_id.id
  redirect "user/#{params[:id]}"
end

get '/user/:id/following' do
  @user = User.find(params[:id])
  @followings = @user.following
  erb :"user_pages/user_following", :followings => @followings
end

get '/user/:id/followers' do
  @user = User.find(params[:id])
  @followers = @user.followers
  erb :"user_pages/user_followers", :followers => @followers
end

# ---- For the API ----- #

get '/api/v1/:apitoken/users/:id' do
  @users = User.find(params[:id])
end

get '/api/v1/:apitoken/users/:id/tweets' do
  @tweets = Tweet.find(:user_id => :id)
end
