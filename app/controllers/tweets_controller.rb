require 'sinatra'

class TweetsController < Sinatra::Base
  get '/tweets/recent' do
    erb :"tweet_pages/tweet_recent"
  end

  post '/tweets/new' do
    erb :"app_pages/home"
  end

  get '/tweets' do
    erb :"tweet_pages/tweet_list"
  end

  get '/tweets/:number' do
    erb :"tweet_pages/tweet", :tweet_num => :number
  end
end