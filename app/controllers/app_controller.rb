enable :sessions
helpers SessionsHelper

get '/' do
  if !logged_in?
    home_html = $redis.get('home_html')
    if home_html.nil?
      @tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
      @likes_hash = Like.group(:tweet_id).count
      @retweets_hash = Tweet.group(:retweet_id).count
      #@tweets_info = Like.group(:tweet_id).count.merge(Tweet.group(:retweet_id).count){|key,oldval,newval| [oldval.to_i].to_a + [newval.to_i].to_a }
      home_html = erb :"app_pages/home"
      $redis.set('home_html', home_html)
    end
    home_html
  else
    @tweets = Tweet.where(user_id: Follower.where(followed_by_id: session[:user_id]).to_a.map{|value| value.user_id})
    @user_likes = Like.where(user_id: session[:user_id]).select(:tweet_id).to_a.map{|value| value.tweet_id}
    @likes_hash = Like.group(:tweet_id).count
    @retweets_hash = Tweet.group(:retweet_id).count
    erb :"app_pages/home"
  end
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end
