require_relative '../tests_helper'

require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
require_relative "../../app/models/mention"
require_relative "../../app/models/like"
require_relative "../../app/models/hashtag"

RSpec.describe Hashtag do
  before do
    User.delete_all
    Tweet.delete_all
    Hashtag.delete_all
    @dummycorrectuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet = Tweet.new(tweet: "Hello! This is my first tweet.", user_id: @dummycorrectuser.id)
    @correcthashtag = Hashtag.new(user_id: @dummycorrectuser.id, tweet_id: @correcttweet.id, hashtag: "COSI105BHashtag")
    @incorrecthashtag1 = Hashtag.new(user_id: @dummycorrectuser.id, hashtag: "DummyHashtag")
    @incorrecthashtag2 = Hashtag.new(tweet_id: @correcttweet.id)
  end

  it "must create a valid hashtag" do
    @correcthashtag.save.must_equal(true)
  end

  it "must have a tweet id" do
    @incorrecthashtag1.save.must_equal(false)
  end

  it "must have a user id and hashtag string" do
    @incorrecthashtag2.save.must_equal(false)
  end
end
