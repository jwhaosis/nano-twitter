enable :sessions
helpers SessionsHelper

get '/' do
  if !logged_in?
    if !$redis.get('html').nil?
      return $redis.get('html')
    else
      @logged_in_tweets = Tweet.where(user_id: Follower.where(followed_by_id: session[:user_id]).to_a.map{|value| value.user_id}) if logged_in?
      @tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
      @likes_hash = Like.group(:tweet_id).count
      @retweets_hash = Tweet.group(:retweet_id).count
      html = erb :"app_pages/home"
      $redis.set('html', html)
      return html
    end
  else
    @logged_in_tweets = Tweet.where(user_id: Follower.where(followed_by_id: session[:user_id]).to_a.map{|value| value.user_id}) if logged_in?
    @tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
    @likes_hash = Like.group(:tweet_id).count
    @retweets_hash = Tweet.group(:retweet_id).count
    erb :"app_pages/home"
  end
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end
