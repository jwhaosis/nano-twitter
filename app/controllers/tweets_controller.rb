require 'byebug'

enable :sessions

helpers SessionsHelper

get '/tweets/recent' do
  @tweets = Tweet.order(:created_at).first(50)
  erb :"tweet_pages/tweet_recent"
end

post '/tweets/new' do
  if post_tweet params[:tweet]
    parse_hashtag_and_mention params[:tweet], @new_tweet.id
    redirect "user/#{current_user.id}"
  else
    flash[:danger] = 'Sorry, cannot tweet at this time. Please try again.'
    redirect back
  end
end

get '/tweets' do
  erb :"tweet_pages/tweet_list"
end

get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  erb :"tweet_pages/tweets"
end

post '/tweets/:id/unlike' do
  tweet_id = Tweet.find(params[:id]).id
  unlike tweet_id
  redirect back
end

post '/tweets/:id/like' do
  tweet_id = Tweet.find(params[:id]).id
  like tweet_id
  redirect back
end

post '/tweets/search' do
  erb :"tweet_pages/tweet_list"
end

post '/tweets/:tweet/retweet' do
  current_tweet = Tweet.find(params[:tweet])
  Tweet.create!(tweet: current_tweet.tweet, user_id: current_user.id, retweet_id: current_tweet.id)
  redirect "user/#{current_user.id}"
end

# ---- For the API ----- #

get '/api/v1/:apitoken/tweets/recent' do
  tweets = Tweet.all.order(created_at: :desc).first(100)
  if !tweets.empty?
    @tweets = tweets.as_json
  end
end

get '/api/v1/:apitoken/tweets/:id' do
  tweets = Tweet.find_by(id: :id)
  if !tweets.empty?
    @tweets = tweets.as_json
  end
end

post '/api/v1/:apitoken/tweets/new' do
  #add info from apitoken here
end

delete '/api/v1/:apitoken/tweets/:id/delete' do
  tweet = Tweet.find_by(id: :id)
  if !tweet.empty?
    tweet.destroy
  end
end
