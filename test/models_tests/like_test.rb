require_relative '../tests_helper'

require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
require_relative "../../app/models/mention"
require_relative "../../app/models/like"

RSpec.describe Like do
  before do
    User.delete_all
    Tweet.delete_all
    Like.delete_all
    @dummycorrectuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet = Tweet.new(tweet: "Hello! This is my first tweet.", user_id: @dummycorrectuser.id)
    @correctlike = Like.new(user_id: @dummycorrectuser.id, tweet_id: @correcttweet.id)
    @incorrectlike1 = Like.new(user_id: @dummycorrectuser.id)
    @incorrectlike2 = Like.new(tweet_id: @correcttweet.id)
  end

  it "must create a valid like" do
    @correctlike.save.must_equal(true)
  end

  it "must have a tweet id" do
    @incorrectlike1.save.must_equal(false)
  end

  it "must have a user id" do
    @incorrectlike2.save.must_equal(false)
  end
end
