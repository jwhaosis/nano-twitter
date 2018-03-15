require_relative "../helpers/test_interface_helper"

test_helper = TestInterfaceHelper.new

get '/test/reset/all' do
  test_helper.reset_all
end

post '/test/reset/testuser' do
  test_helper.reset_testuser
end

get '/test/status' do
  erb :"stat_pages/status"
end

get '/test/version' do
  erb :"stat_pages/version"
end

get '/test/reset/standard' do
  tweet_count = params[:tweets]
  test_helper.reset_all
  test_helper.reset_standard tweet_count
end

get '/test/users/create' do
  user_count = params[:count]
  tweet_count = params[:tweets]
  test_helper.create_users user_count tweet_count
end

get '/test/user/:id/tweets' do
  tweet_count = params[:count]
  test_helper.create_tweets :id, tweet_count
end

get '/test/user/:id/follow' do
  follow_count = params[:count]
  test_helper.create_follows :id, follow_count
end

get '/test/user/follow' do
  follow_count = params[:count]
  test_helper.populate_follows follow_count
end
