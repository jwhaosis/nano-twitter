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
  if !User.where(name: params[:user][:name]).empty?
    flash[:danger] = 'Username already taken.'
    redirect '/user/update_profile'
  elsif !User.where(email: params[:user][:email]).nil?
    flash[:danger] = 'Email already exists.'
    redirect '/user/update_profile'
  else
    @user = User.new(params[:user])
  end

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
    flash[:error] = 'Invalid email/password combination.'
    redirect back
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile' do
  erb :'user_pages/profile', :locals => { :user => current_user }
end

get '/user/update_profile' do
  erb :'user_pages/update_profile', :locals => { :user => current_user }
end

post '/user/update_profile' do
  if !User.where(name: params[:user][:name]).empty? && current_user.name != params[:user][:name]
    flash[:danger] = 'Username already taken.'
    redirect '/user/update_profile'
  elsif !User.where(email: params[:user][:email]).nil? && current_user.email != params[:user][:email]
    flash[:danger] = 'Email already taken.'
    redirect '/user/update_profile'
  else
    current_user.update(params[:user])
  end

  if current_user.save
    flash[:success] = 'Profile updated successfully.'
    redirect '/'
  else
    flash[:danger] = 'Failed to update profile'
    redirect back
  end
end

# all the tweets of user_id: id
get '/user/:id' do
  @searched_user = User.find(params[:id])
  @tweets = @searched_user.tweets.order(created_at: :desc)
  erb :'user_pages/user_tweets'
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
