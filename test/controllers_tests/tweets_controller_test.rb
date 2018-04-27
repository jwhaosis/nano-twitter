require_relative '../tests_helper'
require 'rspec'
require_relative "../../app/controllers/app_controller"
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
    assert response.ok?
    response.body.must_include('Something')
  end

  it 'should get the second tweet' do
    get "/tweets/#{@correcttweet2.id}"
    assert response.ok?
    response.body.must_include('Something')
  end

  it 'should get the recent tweets' do
<<<<<<< Updated upstream
    get '/tweets/recent'
    assert last_response.ok?
  end

  it 'should get the tweets from a user id' do
    get '/tweets/:id'
    assert last_response.ok?
  end
=======
    get "/tweets/recent"
    assert response.ok?
    response.body.must_include('tweet_recent')
  end

  
>>>>>>> Stashed changes
end
