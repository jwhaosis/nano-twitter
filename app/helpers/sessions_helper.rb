require 'sinatra/base'

module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def is_following? user_id
    return !Follower.where(followed_by_id: current_user.id, user_id: user_id).empty?
  end

  def follow user_id
    Follower.create!(user_id: user_id, followed_by_id: current_user.id)
  end

  def unfollow user_id
    Follower.where(user_id: user_id, followed_by_id: current_user.id).first.destroy
  end

  def is_liking? tweet_id
    return !Like.where(user_id: current_user.id, tweet_id: tweet_id).empty?
    byebug
  end

  def like tweet_id
    Like.create!(user_id: current_user.id, tweet_id: tweet_id)
  end

  def unlike tweet_id
    Like.where(user_id: current_user.id, tweet_id: tweet_id).first.destroy
  end

  def logged_in?
    !current_user.nil?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

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
      byebug
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
      @tweets = Tweet.where(user_id: mentioned_user_id)
    elsif hashtag_list.length == 1 && !mentions_list.any?
      hashtag_id = Hashtag.where(hashtag: "#help").first.id
      @tweets = Tweet.joins(:tweettags).where("tweettags.hashtag_id = #{hashtag_id}")
    else
      @tweets = Tweet.where('lower(tweet) ~ ?', word_list.map(&:downcase).join('|'))
    end
    if !@tweets.nil?
      @tweets = @tweets.order(:created_at).first(50)
    end
  end
end
