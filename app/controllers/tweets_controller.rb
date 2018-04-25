enable :sessions

helpers SessionsHelper
helpers TweetsHelper

get '/tweets/recent' do
  @tweets = Tweet.order(:created_at).last(50)
  erb :"tweet_pages/tweet_recent"
end

post '/tweets/new' do
  if post_tweet current_user.id, params[:tweet]
    #parse_hashtag_and_mention params[:tweet], @new_tweet.id
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
  retweet = Tweet.new(tweet: current_tweet.tweet, user_id: current_user.id, retweet_id: current_tweet.id)
  EM.run {
    request = EM::HttpRequest.new("#{ENV['DB_HELPER']}/create/retweet").post :body => retweet.to_json
    EM.stop
  }
  redirect "user/#{current_user.id}"
end
