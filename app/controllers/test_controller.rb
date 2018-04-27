helpers TestInterfaceHelper

get '/test/reset/all' do
  reset_all
end

get '/test/reset/testuser' do
  reset_testuser
end

get '/test/status' do
  erb :"stat_pages/status"
end

get '/test/version' do
  erb :"stat_pages/version"
end

get '/test/reset/standard' do
  user_count = params[:users].to_i
  follow_count = params[:followers].to_i
  tweet_count = params[:tweets].to_i
  reset_all
  reset_standard user_count, follow_count, tweet_count
end

get '/test/users/create' do
  user_count = params[:count].to_i
  tweet_count = params[:tweets].to_i
  create_users user_count, tweet_count
  urls = ["https://scuteser-2.herokuapp.com","https://scuteser-3.herokuapp.com","https://scuteser-4.herokuapp.com"]
  EM.run {
    multi = EM::MultiRequest.new
    urls.each do |url|
      multi.add url, EM::HttpRequest.new("#{url}/test/user/pull").post
    end
    multi.callback do
      EM.stop
    end
  }
end

post '/test/users/pull' do
  pull_users
  pull_tweets
end

get '/test/user/:id/tweets' do
  tweet_count = params[:count].to_i
  create_tweets params[:id], tweet_count
  urls = ["https://scuteser-2.herokuapp.com","https://scuteser-3.herokuapp.com","https://scuteser-4.herokuapp.com"]
  EM.run {
    multi = EM::MultiRequest.new
    urls.each do |url|
      multi.add url, EM::HttpRequest.new("#{url}/test/tweets/pull").post
    end
    multi.callback do
      EM.stop
    end
  }
end

post '/test/tweets/pull' do
  pull_tweets
end

get '/test/user/:id/follow' do
  follow_count = params[:count].to_i
  create_follows params[:id], follow_count
  urls = ["https://scuteser-2.herokuapp.com","https://scuteser-3.herokuapp.com","https://scuteser-4.herokuapp.com"]
  EM.run {
    multi = EM::MultiRequest.new
    urls.each do |url|
      multi.add url, EM::HttpRequest.new("#{url}/test/follows/pull").post
    end
    multi.callback do
      EM.stop
    end
  }
end

get '/test/user/follow' do
  follow_count = params[:count].to_i
  populate_follows follow_count
end

get '/test/follows/pull' do
  pull_follows
end

get '/test/reset/cache' do
  reset_cache
end
