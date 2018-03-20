require_relative '../tests_helper'
require 'rspec'
require_relative "../../app/controllers/app_controller"
require_relative "../../app/controllers/followers_controller"
require_relative "../../app/controllers/tweets_controller"
require_relative "../../app/controllers/users_controller"

RSpec.describe AppController do
  it 'should load homepage' do
    get '/'
    assert last_response.ok?
    last_response.body.must_include('home')
  end
end
