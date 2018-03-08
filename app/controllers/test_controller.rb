require 'sinatra'

get '/test/reset/all' do
  User.delete_all
  Follower.delete_all
  Tweet.delete_all
  User.create(
      first_name: "test",
      last_name: "user",
      email: "testuser@sample.com",
      password: "password"
  )
end

post '/test/reset/testuser' do
  User.where(first_name: "test", last_name: "user", email: "testuser@sample.com").first.destroy
  User.create(
      first_name: "test",
      last_name: "user",
      email: "testuser@sample.com",
      password: "password"
  )
end

get '/test/status' do
  erb :"stat_pages/status"
end

get '/test/version' do
  erb :"stat_pages/version"
end

get '/test/reset/standard' do
  tweet_count = params[:tweets]
  redirect "/test/reset/all"
  count = 0
  CSV.foreach('./db/seeds/tweets.csv') do |tweets_row|
    # only import 1000
    if (tweet_count==nil || count < tweet_count)
      user_id = tweets_row[0]
      tweet = tweets_row[1]
      created_at = tweets_row[2]
      Tweet.create(
          user_id: user_id.to_i,
          tweet: tweet,
          created_at: Date.parse(created_at)
      )
    end
    count += 1
  end
end

get '/test/users/create' do
  user_count = params[:count]
  tweet_count = params[:tweets]
  user_count ||= 1
  tweet_count ||= 0
  (0..user_count).each do |tweet_num|
    name_array = Faker::Name.name.split(" ")
    user = User.create(
        first_name: name_array[0],
        last_name: name_array[1],
        email: "testuser@sample.com",
        password: "password"
    )
    redirect "test/user/#{user.id}/tweets/tweet_count"
  end
end

get '/test/user/:id/tweets' do
  user = User.where(first_name: "test", last_name: "user", email: "testuser@sample.com").first if(id=="testuser")
  user ||= User.where(id: id)
  tweet_count = params[:count]
  (0..tweet_count).each do |tweet_num|
    user.tweets.create(tweet: "fake", created_at: Date.parse(created_at))
  end
end

get '/test/user/:id/follow' do
  user = User.where(first_name: "test", last_name: "user", email: "testuser@sample.com").first if(id=="testuser")
  user ||= User.where(id: id)
  follow_count = params[:count]
  (0..follow_count).each do |tweet_num|
    user.follows.create(followed_by_id: rand(User.count))
  end
end

get '/test/user/follow' do
  user = User.where(first_name: "test", last_name: "user", email: "testuser@sample.com").first if(id=="testuser")
  user ||= User.where(id: id)
  follow_count = params[:count]
  (0..follow_count).each do |tweet_num|
    follower = User.where(id: rand(User.count))
    follower = User.where(id: rand(User.count)) if follower == user
    follower.follows.create(user.id)
  end
end
