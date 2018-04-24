enable :sessions
helpers SessionsHelper
helpers CachingHelper
helpers DatabaseHelper
include EM::Deferrable

get '/' do
  home = homepage_cache
  if logged_in?
    @tweets = generic_tweet_cache
    @user_likes = user_likes_cache session[:user_id]
    home = erb :"app_pages/home"
  end
  home
end

get '/timeline' do
  @tweets = timeline_tweet_cache session[:user_id]
  @user_likes = user_likes_cache session[:user_id]
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  if logged_in?
    @user_likes = Like.where(user_id: session[:user_id]).select(:tweet_id).to_a.map{|value| value.tweet_id}
  end
  erb :"app_pages/search"
end

get '/test/write' do
  create_async "user", User.first
end
