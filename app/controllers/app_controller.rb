require 'sinatra'

class AppController < Sinatra::Base
  get '/' do
    erb :"app_pages/home"
  end

  get '/search' do
    erb :"app_pages/search"
  end
end