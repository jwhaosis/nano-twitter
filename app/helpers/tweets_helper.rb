require 'sinatra/base'

module TweetsHelper

  def post_tweet body
    @new_tweet = Tweet.new(tweet: body, user_id: current_user.id)
    return @new_tweet.save
  end

  def parse_hashtag_and_mention body, tweet_id
    hashtag_list = body.scan(/#[a-zA-Z]*/)
    hashtag_list.each do |hashtag|
      Hashtag.new(hashtag: hashtag).save if Hashtag.where(hashtag: hashtag).first.nil?
      hashtag_id = Hashtag.where(hashtag: hashtag).first.id
      Tweettag.new(hashtag_id: hashtag_id, tweet_id: tweet_id).save
    end
    mentions_list = body.scan(/@[a-zA-Z]*/)
    mentions_list.each do |mention|
      user = User.where(name: mention[1..-1]).first
      #don't add to mentions db if user doesn't exist
      if !user.nil?
        Mention.new(tweet_id: tweet_id, mentioned_user_id: user.id).save
      end
    end
  end

  #search on homepage
  def search body
    word_list = body.split()
    hashtag_list = body.scan(/#[a-zA-Z]*/)
    mentions_list = body.scan(/@[a-zA-Z]*/)

    if mentions_list.length == 1 && !hashtag_list.any?
      mentioned_user_id = User.where(name: mentions_list.first[1..-1])
      tweets = (Tweet.joins(:user).select("tweets.*, users.name")).where(user_id: mentioned_user_id).order('created_at DESC')
    elsif hashtag_list.length == 1 && !mentions_list.any?
      hashtag_id = Hashtag.where(hashtag: "#help").first.id
      tweets = (Tweet.joins(:user).select("tweets.*, users.name")).joins(:tweettags).where("tweettags.hashtag_id = #{hashtag_id}").order('created_at DESC')
    else
      tweets = (Tweet.joins(:user).select("tweets.*, users.name")).where('lower(tweet) ~ ?', word_list.map(&:downcase).join('|')).order('created_at DESC')
    end
    if !tweets.nil?
      tweets = tweets.to_json
      @tweets = JSON.parse tweets
    end
  end
end
