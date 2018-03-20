require_relative '../tests_helper'
require 'rspec'
# require_relative "../../app/controllers/app_controller"
# require_relative "../../app/controllers/followers_controller"
# require_relative "../../app/controllers/tweets_controller"
require_relative "../../app/controllers/users_controller"

RSpec.describe UserController do
  before do
    User.delete_all
    @correctuser = User.new(name: "Sylvia Plath", email: "sylvia@test.com", password: "sylvia456")
  end

  it "has a name" do
    @correctuser.name.must_equal "Sylvia Plath"
  end

  it "has an email" do
    @correctuser.email.must_equal "sylvia@test.com"
  end

  it "has a password" do
    @correctuser.password.must_equal "sylvia456"
  end

  it "should create the correct user" do
    @correctuser.save.must_equal(true)
  end

#post '/user/register' do
  describe "POST on /user/register" do
    it "must register a new user" do
      post('/user/register/attempt',
        {
          :name => correctuser.name,
          :email => correctuser.email,
          :password => correctuser.password})
      last_response.status.must_equal 302
      userisfound = User.where(name: correctuser.username).take
      userisfound.name.must_equal correctuser.name
      userisfound.email.must_equal correctuser.email
    end
  end

  describe "POST on /login" do
    it "must log in with correct credentials" do
      correctuser.save
      post('/login',
        {
          :name => correctuser.username,
          :password => correctuser.password})
      last_response.status.must_equal 302
    end

    it "cannot log in with incorrect credentials" do
      correctuser.save
      post('/login',
        {
          :name => correctuser.name,
          :password => "123"})
      last_response.status.must_equal 400
      end
    end
end
