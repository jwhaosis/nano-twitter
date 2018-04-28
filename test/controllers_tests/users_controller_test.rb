  require_relative '../tests_helper'
  # require 'rspec'
  require_relative "../../app"

  describe "Users Controller Test" do
    before do
      User.delete_all
      @correctuser = User.new(name: "Sylvia Plath", email: "sylvia@test.com", password_digest: "sylvia456")
    end

    it "has a name" do
      @correctuser.name.must_equal "Sylvia Plath"
    end

    it "has an email" do
      @correctuser.email.must_equal "sylvia@test.com"
    end

    it "has a password" do
      @correctuser.password_digest.must_equal "sylvia456"
    end

    it "should create the correct user" do
      @correctuser.save.must_equal(true)
    end
  end

  #post '/user/register' do
    describe "POST on /user/register" do
      it "must register a new user" do
        post('/user/register',
          {
            :name => @correctuser.name,
            :email => @correctuser.email,
            :password_digest => @correctuser.password})
        last_response.status.must_equal 302
        userisfound = User.where(name: @correctuser.name).take
        userisfound.name.must_equal @correctuser.name
        userisfound.email.must_equal @correctuser.email
      end
    end

  describe "POST on /login" do
    it "must log in with correct credentials" do
      @correctuser.save
      post('/login',
        {
          :email => @correctuser.email,
          :password_digest => @correctuser.password})
      last_response.status.must_equal 302
    end

    it "cannot log in with incorrect credentials" do
      correctuser.save
      post('/login',
        {
          :email => @correctuser.email,
          :password_digest => "123"})
      last_response.status.must_equal 400
      end

      it 'should logout' do
        get '/logout'
        assert last_response.ok?
        follow_redirect!
        assert last_response.ok?
      end

      it 'should get the user profile' do
        get '/profile'
        assert last_response.ok?
      end

      if 'should be able to update user profile'
        get '/user/update_profile' do
        assert last_response.ok?
      end
    end
  end
