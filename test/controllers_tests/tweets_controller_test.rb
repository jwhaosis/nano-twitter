require_relative '../tests_helper'
# require 'rspec'
require_relative "../../app"


describe "Tweets Controller Test" do
  before do
    User.delete_all
    Tweet.delete_all
    @dummycorrectuser = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correcttweet1 = Tweet.new(tweet: "Hello! Dummy tweet 1.", user_id: @dummycorrectuser.id, created_at: Time.now)
    @correcttweet2 = Tweet.new(tweet: "Hello! Dummy tweet 2.", user_id: @dummycorrectuser.id, created_at: Time.now)
  end

  # # get '/tweets/:id' do
  # it 'should get the first tweet' do
  #   get "/tweets/#{@correcttweet1.id}"
  #   assert last_response.ok?
  #   assert last_response.body.include?('Hello')
  # end
  #
  # it 'should get the second tweet' do
  #   get "/tweets/#{@correcttweet2.id}"
  #   assert last_response.ok?
  #   assert last_response.body.include?('Hello')
  # end

  it 'should get the recent tweets' do
    get '/tweets/recent'
    assert last_response.ok?
  end

  it 'should get list of tweets' do
    get '/tweets'
    assert last_response.ok?
  end
end
