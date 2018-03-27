require_relative '../helpers/sessions_helper'

enable :sessions

helpers SessionsHelper

get '/' do
  #current_user.following_tweets(session[:user_id]).first(50)
  @tweets = logged_in? ? Tweet.where(id: session[:user_id]).select(:user_id, :tweet).last(50) : Tweet.joins(:user).select(:name, :tweet).last(50)
  byebug
  erb :"app_pages/home"
end

get '/search' do
  erb :"app_pages/search"
end
