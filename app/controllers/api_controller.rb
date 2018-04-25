get '/api/v1/:apitoken/tweets/recent' do
  token = params[:apitoken].to_i
  cache = []
  if token == 0
    cache = generic_tweet_cache token, true
  else
    cache = user_tweet_cache token, true
  end
  cache.to_json
end

get '/api/v1/:apitoken/tweets/:id' do
  tweet_id = params[:id].to_i
  Tweet.where(id: tweet_id).first.to_json
end

post '/api/v1/:apitoken/tweets/new' do
  token = params[:apitoken].to_i
  tweet = []
  if token != 0
    id = $redis.get("tweet_inc")
    $redis.incr "tweet_inc"
    request.body.rewind
    body = request.body.read.to_s
    if body.nil?
      body = Faker::Hacker.say_something_smart
    end
    tweet = Tweet.create(id: id, user_id: token, tweet: body, created_at: Time.now)
  end
  tweet.to_json
end

get '/api/v1/:apitoken/users/:id' do
  user_id = params[:id].to_i
  User.where(id: user_id).first.to_json
end

get '/api/v1/:apitoken/users/:id/tweets' do
  user_id = params[:id].to_i
  cache = user_tweet_cache user_id, true
  cache.to_json
end
