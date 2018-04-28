require_relative '../tests_helper'
# require 'rspec'
require_relative "../../app"


describe "Tweets Controller Test" do

  it 'should get the recent tweets' do
    get '/tweets/recent'
    assert last_response.ok?
  end

  it 'should get list of tweets' do
    get '/tweets'
    assert last_response.ok?
  end
end
