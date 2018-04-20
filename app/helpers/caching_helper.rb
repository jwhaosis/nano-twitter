require 'sinatra'
require 'byebug'

module CachingHelper
  def homepage_cache redis, refresh = false
    home_html = redis.get('home_html')
    if home_html.nil? || refresh
      @tweets = generic_tweet_cache redis
      home_html = erb :"app_pages/home"
      redis.set('home_html', home_html)
    end
    home_html
  end

  def tweetinfo_cache redis, refresh = false
    tweet_info = redis.get('tweet_info')
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
      redis.set('tweet_info', tweet_info)
    else
      tweet_info = eval tweet_info
    end
    tweet_info
  end

  def generic_tweet_cache redis, refresh = false
    generic_tweets = redis.get('generic_tweets')
    if generic_tweets.nil? || refresh
      generic_tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
      redis.set('generic_tweets', generic_tweets.to_json)
    else
      generic_tweets = JSON.parse generic_tweets
    end
    generic_tweets
  end

end
