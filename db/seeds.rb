require 'csv'
require_relative '../app/models/user'
require_relative '../app/models/follower'
require_relative '../app/models/tweet'

#reset db
User.delete_all
Follower.delete_all
Tweet.delete_all

#load users
count = 0
CSV.foreach('./db/seeds/users.csv') do |user|
  #only import 100
  if (count < 100)
    username = user[1].downcase.gsub(/\W+/, '')
    User.create(
        name: username,
        email: "#{username}@email.com",
        password: "password"
    )
  end
  count += 1
end

count = 0
CSV.foreach('./db/seeds/follows.csv') do |follow|
  # only import 250
  if (count < 250)
    user_id = follow[0]
    follows_user_id = follow[1]
    Follower.create(
        user_id: follows_user_id.to_i,
        followed_by_id: user_id.to_i
    )
  end
  count += 1
end

count = 0
CSV.foreach('./db/seeds/tweets.csv') do |tweets_row|
  # only import 1000
  if (count < 1000)
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