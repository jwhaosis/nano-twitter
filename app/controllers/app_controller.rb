enable :sessions

helpers SessionsHelper

get '/' do
  @tweets = logged_in? ? current_user.following_tweets(session[:user_id]).order(:created_at).first(50) : Tweet.order(:created_at).first(50)
  erb :"app_pages/home"
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end