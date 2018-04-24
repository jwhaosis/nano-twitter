require 'sinatra/base'
require 'eventmachine'
require 'em-http'

module UsersHelper

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
  end

  def like tweet_id
    like = Like.new(user_id: current_user.id, tweet_id: tweet_id)
    EM.run {
      request = EM::HttpRequest.new("#{ENV['DB_HELPER']}/create/like").post :body => like.to_json
      request.callback{
        puts "success"
        EM.stop
      }
      request.errback{
        puts "failed"
        EM.stop
      }
    }
  end

  def unlike tweet_id
    like = Like.new(user_id: current_user.id, tweet_id: tweet_id)
    EM.run {
      request = EM::HttpRequest.new("#{ENV['DB_HELPER']}/delete/like").post :body => like.to_json
      request.callback{
        puts "success"
        EM.stop
      }
      request.errback{
        puts "failed"
        EM.stop
      }
    }
  end
end
