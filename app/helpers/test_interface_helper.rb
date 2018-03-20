require "active_record"
require_relative "../models/user"
require_relative "../models/follower"
require_relative "../models/tweet"

class TestInterfaceHelper
  def reset_all
    User.delete_all
    Follower.delete_all
    Tweet.delete_all
    User.create(
        name: "testuser",
        email: "testuser@sample.com",
        password: "password"
    )
  end

  def reset_testuser
    User.where(name: "testuser", email: "testuser@sample.com").first.destroy
    User.create(
      name: "testuser",
      email: "testuser@sample.com",
      password: "password"
    )
  end

  def reset_standard tweet_count
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

  def create_users user_count, tweet_count
    user_count ||= 1
    tweet_count ||= 0
    (0..user_count).each do |user_num|
      user = User.create(
          name: Faker::Name.name,
          email: "testuser@sample.com",
          password: "password"
      )
      (0..tweet_count).each do |tweet_num|
        user.tweets.create(tweet: "fake", created_at: Date.parse(created_at))
      end
    end
  end

  def create_tweets id, tweet_count
    user = User.where(name: "testuser", email: "testuser@sample.com").first if(id=="testuser")
    user ||= User.where(id: id)
    (0..tweet_count).each do |tweet_num|
      user.tweets.create(tweet: "fake", created_at: Date.parse(created_at))
    end
  end

  def create_follows id, follow_count
    user = User.where(name: "testuser", email: "testuser@sample.com").first if(id=="testuser")
    user ||= User.where(id: id)
    (0..follow_count).each do |tweet_num|
      user.follows.create(followed_by_id: rand(User.count))
    end
  end

  def populate_follows follow_count
    (0..follow_count).each do |follower_num|
      user = User.where(id: rand(User.count))
      (0..follow_count).each do |tweet_num|
        follower = User.where(id: rand(User.count))
        follower = User.where(id: rand(User.count)) if follower == user
        follower.follows.create(user.id)
      end
    end
  end


end
