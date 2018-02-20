require 'sinatra'

post 'user/login' do

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
