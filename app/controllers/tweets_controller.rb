require 'byebug'

get '/tweets/recent' do
  @tweets = Tweet.order(:created_at).first(50)
  erb :"tweet_pages/tweet_recent"
end

post '/tweets/new' do
  @user = User.where(id: session[:user_id]).first
  @user.post_tweet params[:tweet][:tweet]
  @tweets = @user.following_tweets(session[:user_id]).first(50)
  erb :"app_pages/home"
end

get '/tweets' do
  erb :"tweet_pages/tweet_list"
end

get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  erb :"tweet_pages/tweets"
end

post '/tweets/:id/like' do
  tweet_id = Tweet.find(params[:id]).id
  unlike tweet_id
  redirect back
end

post '/tweets/:id/unlike' do
  tweet_id = Tweet.find(params[:id]).id
  like tweet_id
  redirect back
end

post '/tweets/search' do
  erb :"tweet_pages/tweet_list"
end

post '/tweets/:id/retweet' do
  current_tweet = Tweet.find(params[:id])
  Tweet.create!(tweet: current_tweet.tweet, user_id: current_user.id, retweet_id: current_tweet.id)
end

# ---- For the API ----- #

get '/api/v1/:apitoken/tweets/recent' do
  tweets = Tweets.find(:all, :order => "created_at desc", :limit =>100)
  while !tweets.empty?
    tweets.reverse
  end
  @tweets = tweets.as_json
end

get '/api/v1/:apitoken/tweets/:id' do
  tweets = Tweets.find_by(id: :id)
  if !tweets.empty?
    @tweets = tweets.as_json
  end
end

post '/api/v1/:apitoken/tweets/new' do
  tweet = Tweets.new
  #add info from apitoken here
end

delete '/api/v1/:apitoken/tweets/:id/delete' do
  tweet = Tweets.find_by(id: :id)
  if !tweet.empty?
    tweet.destroy
  end
end
