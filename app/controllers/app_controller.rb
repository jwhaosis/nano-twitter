enable :sessions
helpers SessionsHelper
helpers CachingHelper
include EM::Deferrable

get '/' do
  if !logged_in?
    homepage_cache
  else
    @tweets = generic_tweet_cache
    #@logged_in_tweets = Tweet.where(user_id: Follower.where(followed_by_id: session[:user_id]).to_a.map{|value| value.user_id})
    @user_likes = Like.where(user_id: session[:user_id]).select(:tweet_id).to_a.map{|value| value.tweet_id}
    erb :"app_pages/home"
  end
end

get '/feed' do
  byebug
  # @tweets = generic_tweet_cache
  @tweets = Tweet.where(user_id: Follower.where(followed_by_id: session[:user_id]).to_a.map{|value| value.user_id})
  @user_likes = Like.where(user_id: session[:user_id]).select(:tweet_id).to_a.map{|value| value.tweet_id}
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end

get '/test/write' do
  EM.run {
    request = EM::HttpRequest.new('http://scuteser-db1.herokuapp.com/async').post :body => User.first.to_json
    request.callback{
      puts "success"
      EM.stop
    }
    request.errback{
      puts "failed"
      EM.stop
    }
  }
  "done"
end
