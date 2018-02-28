require 'sinatra'

class UsersController < Sinatra::Base
  post 'user/login' do
    @user = User.find_by_email(params[:email])
    if @user.password_digest == params[:password_digest]
      give_token
    else
      redirect_to home_url
    end
  end

  post 'user/create' do
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Twitter!"
      erb :"/user"
    else
      flash[:error] = "Please complete all fields"
      render 'new'
    end
  end

  get 'user/register' do
    erb :"app_pages/login"
  end

  get '/user' do
    erb :"user_pages/self"
  end

  get '/user/:number' do
    erb :"user_pages/user", :user_num => :number
  end

  post '/user/:number/follow' do

  end

  get '/user/:number/following' do
    erb :"user_pages/user_following", :user_num => :number
  end

  get '/user/:number/follwers' do
    erb :"user_pages/user_followers", :user_num => :number
  end


  get '/user/:number/tweets' do
    erb :"user_pages/user_tweet", :user_num => :number
  end
end