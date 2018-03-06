require 'sinatra'

get '/test/reset/all' do

end

post '/test/reset/testuser' do

end

get '/test/status' do

end

get '/test/version' do

end

get '/test/reset/standard' do
  tweet_count = params[:tweets]
end

get '/test/users/create' do
  user_count = params[:count]
  tweet_count = params[:tweets]
end

get '/test/user/:id/tweets' do
  #user = User.where(id: id)
  tweet_count = params[:count]
end

get '/test/user/:id/follow' do
  #user = User.where(id: id)
  follow_count = params[:count]

end

get '/test/user/follow' do
  follow_count = params[:count]
end
