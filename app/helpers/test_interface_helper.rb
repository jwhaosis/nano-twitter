require 'faker'
require 'csv'
require 'activerecord-import'

module TestInterfaceHelper
  def reset_all
    ActiveRecord::Base.connection.tables.each do |t|
      if(t != "schema_migrations" && t != "ar_internal_metadata")
        ActiveRecord::Base.connection.execute("TRUNCATE #{t}")
        ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{t}_id_seq restart with 1")
      end
    end
    create_testuser
  end

  def reset_testuser
    test_id = User.where(name: "testuser", email: "testuser@sample.com").first.id
    Tweet.where(user_id: test_id).delete_all
    Mention.where(mentioned_user_id: test_id).delete_all
    Follower.where(user_id: test_id).delete_all
    Follower.where(followed_by_id: test_id).delete_all
    Like.where(user_id: test_id).delete_all
    User.where(id: test_id).delete_all
    create_testuser
  end

  def create_testuser
    User.create(
      id: 1001,
      name: "testuser",
      email: "testuser@sample.com",
      password: "password"
    )
  end

  def reset_standard user_count, follow_count, tweet_count
    seed_users user_count
    seed_follows follow_count
    seed_tweets tweet_count
  end

  def seed_users user_count
    users = []
    count = 0
    CSV.foreach('./db/seeds/users.csv') do |user|
      if user_count == 0 || count<user_count
        username = user[1].downcase.gsub(/\W+/, '')
        users << User.new(id: count+=1, name: username, email: "#{username}@email.com", password: "password")
      end
    end
    User.import users
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE users_id_seq restart with #{count+2}")
  end

  def seed_follows follow_count
    followers = []
    count = 0
    CSV.foreach('./db/seeds/follows.csv') do |follow|
      if follow_count == 0 || count<follow_count
        user_id = follow[0]
        follows_user_id = follow[1]
        followers << Follower.new(id: count+=1, user_id: follows_user_id.to_i, followed_by_id: user_id.to_i)
      end
    end
    Follower.import followers
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE followers_id_seq restart with #{count+1}")
  end

  def seed_tweets tweet_count
    tweets = []
    count = 0
    CSV.foreach('./db/seeds/tweets.csv') do |tweets_row|
      if tweet_count == 0 || count<tweet_count
        user_id = tweets_row[0]
        tweet = tweets_row[1]
        created_at = tweets_row[2]
        tweets << Tweet.new(id: count+=1, user_id: user_id.to_i, tweet: tweet, created_at: Date.parse(created_at))
      end
    end
    Tweet.import tweets
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE tweets_id_seq restart with #{count+1}")
  end

  def create_users user_count, tweet_count
    user_count ||= 1
    tweet_count ||= 0
    [*0...user_count].each do |id|
      name = Faker::Name.first_name
      User.create(name: name, email: "#{name}@email.com", password: "password")
      create_tweets id, tweet_count
    end
    true
  end

  def create_tweets id, tweet_count
    return if tweet_count == 0
    id = User.where(name: "testuser", email: "testuser@sample.com").first.id if(id=="testuser")
    [*0...tweet_count].each do |tweet_num|
      Tweet.create(user_id: id, tweet: Faker::Hacker.say_something_smart, created_at: Faker::Date.backward(14))
    end
    true
  end

  def create_follows id, follow_count
    user = User.where(name: "testuser", email: "testuser@sample.com").first if(id=="testuser")
    user ||= User.where(id: id.to_i)
    followers = [*1...User.count]
    [*0...follow_count.to_i].each do
      Follower.create(user_id: id, followed_by_id: followers.delete_at(rand(followers.length).to_i))
    end
    true
  end

  def populate_follows follow_count
    leaders = [*1...User.count]
    [*0...follow_count].each do |leader_count|
      leader_id = leaders.delete_at(rand(leaders.length).to_i)
      leader = User.where(id: leader_id)
      followers = [*1...User.count].delete_at(leader_id)
      [*0...follow_count].each do |follower_count|
        Follower.create(user_id: leader_id, followed_by_id: followers.delete_at(rand(followers.length).to_i))
      end
    end
    true
  end


end
