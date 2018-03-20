
# require_relative "./app/models/user"
# require_relative "./app/models/tweet"
# require_relative "./app/models/follower"

# require_relative Dir.pwd+'/app/models/user.rb'
# require Dir.pwd +'/user.rb'

# require_relative "../../app/controllers/app_controller"
# require_relative "../../app/controllers/tweets_controller"
# require_relative "../../app/controllers/users_controller"
# require_relative "../../app/controllers/test_controller"
require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
# require_relative './tests_helper'
require 'csv'

RSpec.describe User do
  before do
    User.delete_all
    @correctuser1 = User.new(name: "John Doe", email: "johndoe@test.com", password: "john123")
    @correctuser2 = User.new(name: "Sylvia Plath", email: "Sylvia@gmail.com", password: "sylvia456")
    @incorrectuser1 = User.new(email: "dummy@dummy.com", password: "12345")
    @incorrectuser2 = User.new(name: "Honey", password: "testtest123")
  end

  it "has a first name" do
    @correctuser1.first_name.must_equal "John"
  end

  it "has a last name" do
    @correctuser2.last_name.must_equal "Plath"
  end

  it "has an email" do
    @correctuser1.email.must_equal "johndoe@test.com"
  end

  it "has a password" do
    @correctuser1.password.must_equal "john123"
  end

  it "should create the correct user" do
    @correctuser1.save.must_equal(true)
  end

  it "should create another correct user" do
    @correctuser2.save.must_equal(true)
  end

  it "must check for name" do
    @incorrectuser1.save.must_equal(false)
  end

  it "must check for an email" do
    @incorrectuser2.save.must_equal(false)
  end
end
