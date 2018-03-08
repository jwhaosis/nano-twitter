require_relative '../tests_helper'

describe Tweet do
  before do
    User.delete_all
    Tweet.delete_all
    @dummycorrectuser = User.new(first_name: "John", last_name: "Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet = Tweet.new(tweet: "Hello! This is my first tweet.", user_id: @dummycorrectuser.id)
    @incorrecttweet = Tweet.new(tweet: "Checking tweet with no user id, so incorrect tweet!")

  it "must save a correct tweet" do
    @correcttweet.save.must_equal(true)
  end

  it "must have a user id" do
    @incorrecttweet.save.must_equal(false)
  end
end
