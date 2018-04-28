require_relative '../tests_helper'
require_relative "../../app/controllers/app_controller"
require_relative "../../app/controllers/tweets_controller"
require_relative "../../app/controllers/users_controller"

# require_relative "../../app/controllers/app_controller"
# require 'minitest/autorun'
require 'rack/test'

# require_relative "../../app/controllers/tweets_controller"
# require_relative "../../app/controllers/users_controller"

describe "App Controller Test" do
  it 'should load the home page' do
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('home')
  end
end
