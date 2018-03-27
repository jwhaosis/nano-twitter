require 'csv'
require_relative '../app/models/user'
require_relative '../app/models/follower'
require_relative '../app/models/tweet'

#reset db
User.delete_all
Follower.delete_all
Tweet.delete_all

#load users
CSV.foreach('./db/seeds/users.csv') do |user|
  username = user[1].downcase.gsub(/\W+/, '')
  User.create(
      name: username,
      email: "#{username}@email.com",
      password: "password"
  )
end

#load followers
CSV.foreach('./db/seeds/follows.csv') do |follow|
  user_id = follow[0]
  follows_user_id = follow[1]
  Follower.create(
      user_id: follows_user_id.to_i,
      followed_by_id: user_id.to_i
  )
end

#load tweets
CSV.foreach('./db/seeds/tweets.csv') do |tweets_row|
  user_id = tweets_row[0]
  tweet = tweets_row[1]
  created_at = tweets_row[2]
  Tweet.create(
      user_id: user_id.to_i,
      tweet: tweet,
      created_at: Date.parse(created_at)
  )
end