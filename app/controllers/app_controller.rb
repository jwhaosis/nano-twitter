enable :sessions

helpers SessionsHelper

get '/' do
  @logged_in_tweets = Tweet.where(user_id: Follower.where(followed_by_id: 1).to_a.map{|value| value.user_id}) if logged_in?
  @tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
  @likes_hash = Like.group(:tweet_id).count
  @retweets_hash = Tweet.group(:retweet_id).count
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end
