require_relative '../tests_helper'

require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
require_relative "../../app/models/mention"

RSpec.describe Mention do
  before do
    User.delete_all
    Tweet.delete_all
    Mention.delete_all
    @dummycorrectuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet = Tweet.new(tweet: "Hello! This is my first tweet.", user_id: @dummycorrectuser.id)
    @correctmention = Mention.new(user_id: @dummycorrectuser.id, tweet_id: @correcttweet.id)
    @incorrectmention1 = Mention.new(user_id: @dummycorrectuser.id)
    @incorrectmention2 = Mention.new(tweet_id: @correcttweet.id)
  end

  it "must create a valid mention" do
    @correctmention.save.must_equal(true)
  end

  it "must have a user id" do
    @incorrectmention1.save.must_equal(false)
  end

  it "must have a tweet id" do
    @incorrectmention2.save.must_equal(false)
  end
end
