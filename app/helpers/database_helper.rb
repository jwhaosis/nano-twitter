require 'sinatra'

module DatabaseHelper
  def create_user user
    EM.run {
      request = EM::HttpRequest.new('http://scuteser-db1.herokuapp.com/user/create').post :body => user.to_json
      request.callback{
        puts "success"
        EM.stop
      }
      request.errback{
        puts "failed"
        EM.stop
      }
    }
  end

  def create_tweet
    
  end

  def create_follow

  end

  def create_like

  end

  def create_hashtag

  end

  def create_tweettag

  end

  def create_mention

  end

  def delete_like

  end

  def delete_follow

  end
end
