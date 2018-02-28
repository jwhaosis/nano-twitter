
class UserController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password_digest = params[:password_digest]
    @user.save!
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.password_digest == params[:password_digest]
      give_token
    else
      redirect_to home_url
    end
  end
end