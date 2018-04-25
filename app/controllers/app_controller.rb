enable :sessions
helpers SessionsHelper
helpers CachingHelper
include EM::Deferrable

get '/' do
  if logged_in?
    @tweets = generic_tweet_cache
    @user_likes = user_likes_cache session[:user_id]
    @user_info = user_info_cache session[:user_id]
    erb :"app_pages/home"
  else
    homepage_cache
  end
end

get '/timeline' do
  @tweets = timeline_tweet_cache session[:user_id]
  @user_likes = user_likes_cache session[:user_id]
  @user_info = user_info_cache session[:user_id]
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  if logged_in?
    @user_info = user_info_cache session[:user_id]
    @user_likes = Like.where(user_id: session[:user_id]).select(:tweet_id).to_a.map{|value| value.tweet_id}
  end
  erb :"app_pages/search"
end

get '/user/testuser' do
  @searched_user_info = user_info_cache 1001
  @tweets = user_tweet_cache 1001
  if logged_in?
    @user_likes = user_likes_cache session[:user_id]
  end
  erb :'user_pages/user_tweets'
end

get '/user/testuser/tweet' do
  EM.run {
    request = EM::HttpRequest.new("#{ENV['DB_HELPER']}/create/tweet/1001").post
    EM.stop
  }
  redirect "user/testuser"
end
