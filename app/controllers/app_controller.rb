enable :sessions
helpers SessionsHelper

get '/' do
  if !logged_in?
    byebug
    if !$redis.get('html').nil?
      return $redis.get('html')
    else
      @tweets = Tweet.joins(:user).select("tweets.*, users.name").first(50)
      html = erb :"app_pages/home"
      $redis.set('html', html)
      return html
    end
  else
    @tweets = current_user.following_tweets(session[:user_id]).order(:created_at).first(50)
    erb :"app_pages/home"
  end
end

post '/search' do
  search params[:search]
  erb :"app_pages/search"
end
