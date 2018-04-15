enable :sessions

helpers SessionsHelper

get '/' do
  @tweets = logged_in? ? following_tweets(current_user).order(:created_at).first(50) : Tweet.joins(:user).order(:created_at).first(50)
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end
