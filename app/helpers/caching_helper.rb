require 'sinatra'

module CachingHelper
  def homepage_cache refresh = false
    home_html = $redis.get('home_html')
    if home_html.nil? || refresh
      @tweets = generic_tweet_cache
      home_html = erb :"app_pages/home"
      $redis.set('home_html', home_html)
    end
    home_html
  end

  def tweetinfo_cache refresh = false
    tweet_info = $redis.get('tweet_info')
    if tweet_info.nil? || refresh
      tweet_info = Hash.new
      likes = Like.group(:tweet_id).count
      retweets = Tweet.group(:retweet_id).count
      likes.each_key do |tweet_id|
        if (retweets.has_key?(tweet_id))
          tweet_info[tweet_id] = [likes[tweet_id], retweets[tweet_id]]
        else
          tweet_info[tweet_id] = [likes[tweet_id], 0]
        end
      end
      retweets.each_key do |tweet_id|
        tweet_info[tweet_id] = [0, retweets[tweet_id]] if (!tweet_info.has_key?(tweet_id))
      end
      $redis.set('tweet_info', tweet_info)
    else
      tweet_info = eval tweet_info
    end
    tweet_info
  end

  def generic_tweet_cache refresh = false
    generic_tweets = $redis.get('generic_tweets')
    if generic_tweets.nil? || refresh
      generic_tweets = Tweet.joins(:user).select("tweets.*, users.name").last(50).to_json
      $redis.set('generic_tweets', generic_tweets)
    end
    JSON.parse generic_tweets
  end

  def timeline_tweet_cache id, refresh = false
    key = "user#{id}_timeline"
    timeline_tweets = $redis.get(key)
    if timeline_tweets.nil? || refresh
      timeline_tweets = (Tweet.joins(:user).select("tweets.*, users.name")).where(user_id: Follower.where(followed_by_id: id).to_a.map{|value| value.user_id}).to_json
      $redis.set(key, timeline_tweets)
    end
    JSON.parse timeline_tweets
  end

  def user_tweet_cache id, refresh = false
    key = "user#{id}_tweets"
    user_tweets = $redis.get(key)
    if user_tweets.nil? || refresh
      user_tweets = Tweet.joins(:user).where(user_id: id).select("tweets.*, users.name").last(50).to_json
      $redis.set(key, user_tweets)
    end
    JSON.parse user_tweets
  end

  def user_likes_cache id, refresh = false
    key = "user#{id}_likes"
    user_likes = $redis.get(key)
    if user_likes.nil? || refresh
      user_likes = Like.where(user_id: id).select(:tweet_id).to_a.map{|value| value.tweet_id}.to_json
      $redis.set(key, user_likes)
    end
    JSON.parse user_likes
  end

end
