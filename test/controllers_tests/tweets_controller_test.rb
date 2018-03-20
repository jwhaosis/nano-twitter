require_relative '../tests_helper'
require 'rspec'
require_relative "../../app/controllers/app_controller"
require_relative "../../app/controllers/followers_controller"
require_relative "../../app/controllers/tweets_controller"
require_relative "../../app/controllers/users_controller"

RSpec.describe TweetController do
  before do
    User.delete_all
    Tweet.delete_all
    @dummycorrectuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet1 = Tweet.new(tweet: "Hello! Dummy tweet 1.", user_id: @dummycorrectuser.id, created_at: Time.now)
    @correcttweet2 = Tweet.new(tweet: "Hello! Dummy tweet 2.", user_id: @dummycorrectuser.id, created_at: Time.now)
  end

  # get '/tweets/:id' do
  it 'should get the first tweet' do
    get "/tweets/#{@correcttweet1.id}"
    assert last_response.ok?
    last_response.body.must_include('Some content')
  end

  it 'should get the second tweet' do
    get "/tweets/#{@correcttweet2.id}"
    assert last_response.ok?
    last_response.body.must_include('Some content')
  end
end
