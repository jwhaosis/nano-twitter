require_relative '../tests_helper'
# require_relative "../../app/controllers/app_controller"
# require 'minitest/autorun'
require 'rack/test'

# require_relative "../../app/controllers/tweets_controller"
# require_relative "../../app/controllers/users_controller"

# RSpec.describe AppController do
#   it 'should load homepage' do
#     get '/'
#     assert response.ok?
#     response.body.must_include('home')
#   end
#
#   # Asserts that the response is one of the following types:
#   #
#   # :success: Status code was 200
#   # :redirect: Status code was in the 300-399 range
#   # :missing: Status code was 404
#   # :error: Status code was in the 500-599 range
#
#   it 'should be able to search' do
#     get '/search'
#     assert response.ok?
#     # response.success?.must_equal true
#     # assert_response :success
#     response.body.must_include('search')
#   end
# end

# describe "App Controllers Test" do
#   before do
#     @controller = AppController.new
#   end
#
#   def app
#      Sinatra::Application
#    end
#
#   it "can load home page" do
#     get '/'
#     assert last_response.ok?
#     assert last_response.body.include?('home')
#   end
#
#   it "can search" do
#     get '/search'
#     assert last_response.ok?
#     assert last_response.body.include?('search')
#   end
# end

class AppControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_loads_home_page
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('home')
  end

  # def test_is_able_to_search
  #   post '/search'
  #   assert last_response.ok?
  #   assert last_response.body.include?('search')
  # end
end
