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
CSV.foreach('./db/seeds/users.csv') do |user_row|
  #only import 100
  if (count < 100)
    user_array = user_row.split(/\s*,\s*/)
    user_first = user_array[1]
    User.create(
        first_name: user_first,
        email: "#{user_first}@email.com",
        password: "password"
    )
  end
  count += 1
end

count = 0
CSV.foreach('./db/seeds/follows.csv') do |follows_row|
  # only import 250
  if (count < 250)
    user_id = follows_row[0]
    follows_user_id = follows_row[1]
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