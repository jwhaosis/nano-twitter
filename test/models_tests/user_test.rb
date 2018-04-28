require_relative '../tests_helper'
# require 'rspec'
require_relative "../../app/models/user"
require_relative "../../app/models/tweet"
require_relative "../../app/models/follower"
# require 'csv'

describe "User Model tests" do
  before do
    User.delete_all
    @correctuser1 = User.new(name: "John Doe", email: "johndoe@test.com", password_digest: "john123")
    @correctuser2 = User.new(name: "Sylvia Plath", email: "Sylvia@gmail.com", password_digest: "sylvia456")
    @incorrectuser1 = User.new(email: "dummy@dummy.com", password_digest: "12345")
    @incorrectuser2 = User.new(name: "Honey", password_digest: "testtest123")
  end

  it "must check for name" do
    @incorrectuser1.save.must_equal(false)
  end

  it "must check for an email" do
    @incorrectuser2.save.must_equal(false)
  end

  it "has a name" do
    @correctuser1.name.must_equal "John Doe"
  end

  it "has an email" do
    @correctuser1.email.must_equal "johndoe@test.com"
  end

  it "has a password" do
    @correctuser1.password_digest.must_equal "john123"
  end

  it "should create the correct user" do
    @correctuser1.save.must_equal(true)
  end

  it "should create another correct user" do
    @correctuser2.save.must_equal(true)
  end
end
