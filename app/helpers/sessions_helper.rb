module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def is_following? user_id
    return !Follower.where(followed_by_id: current_user.id, user_id: user_id).empty?
  end

  def follow user_id
    Follower.create!(user_id: user_id, followed_by_id: current_user.id)
  end

  def unfollow user_id
    Follower.where(user_id: user_id, followed_by_id: current_user.id).first.destroy
  end

  def is_liking? tweet_Id
    return !Likes.where(user_id: current_user.id, tweet_id: tweet_id).empty?
  end


  def logged_in?
    !current_user.nil?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
