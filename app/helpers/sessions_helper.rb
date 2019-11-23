module SessionsHelper

  def log_in(user)
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    session[:user_id] = user.id
    user.update_attribute(:remember_digest, User.digest(remember_token))
    current_user
  end

  def log_out
    cookies.delete(:remember_token)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
