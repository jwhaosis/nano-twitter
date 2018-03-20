require 'minitest/autorun'
require 'active_record'
require_relative "../app/helpers/test_interface_helper"
require_relative "../app/models/user"
require_relative "../app/models/tweet"
require_relative "../app/models/follower"

describe "Test Interface Tests" do

  before do
    @helper = TestInterfaceHelper.new
  end

  it "can reset database" do
    @helper.reset_all
    assert_equals 1, User.count
    assert_equals 0, Tweet.count
    assert_equals 0, Follower.count
  end

  it "can reset test user" do
    @helper.reset_testuser
    assert_equals 1, User.count
  end

  it "can reset to standard" do
    @helper.reset_standard 100
    assert_equals 100, Tweet.count
  end

  it "can create users" do
    @helper.reset_all
    @helper.create_users 1, 1
    assert_equals 2, User.count
  end

  it "can create tweets" do
    @helper.reset_all
    @helper.create_tweets 1, 1
    assert_equals 1, Tweet.count
  end

  it "can create follows" do
    @helper.reset_all
    @helper.create_user 1, 1
    @helper.create_follows 1, 1
  end

end
