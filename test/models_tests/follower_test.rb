require_relative '../tests_helper'

require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
require_relative "../../app/models/mention"
require_relative "../../app/models/like"
require_relative "../../app/models/hashtag"
require_relative "../../app/models/follower"


RSpec.describe Follower do
  before do
    User.delete_all
    Tweet.delete_all
    Follower.delete_all
    # Sylvia is following John
    @correctuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correctuserfollower = User.new(name: "Sylvia Plath", email: "Sylvia@gmail.com", password: "sylvia456")
    @correctfollowerrelation = Follower.new(user_id: @correctuser.id, followed_by_id: @correctuserfollower.id)
    @incorrectfollowerrelation1 = Follower.new(user_id: @correctuser.id)
    @incorrectfollowerrelation2 = Follower.new(followed_by_id: @correctuser.id)
  end

  it "must create a valid follower relation" do
    @correctfollowerrelation.save.must_equal(true)
  end

  it "must have a followed_by_id" do
    @incorrectfollowerrelation1.save.must_equal(false)
  end

  it "must have a user id" do
    @incorrectfollowerrelation2.save.must_equal(false)
  end
end
