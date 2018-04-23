require 'sinatra'

module DatabaseHelper
  def create_async model_name, model
    EM.run {
      request = EM::HttpRequest.new("http://scuteser-db1.herokuapp.com/create/#{model_name}").post :body => model.to_json
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

  def delete_async model_name, model
    EM.run {
      request = EM::HttpRequest.new("http://scuteser-db1.herokuapp.com/delete/#{model_name}").post :body => model.to_json
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

end
