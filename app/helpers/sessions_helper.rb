module SessionsHelper
  def log_in(user)
      session[:user_id] = user.id
  end
  #define a current_user for session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  # define to find out if the user is still login
  def logged_in?
    !current_user.nil?
  end
  # define a logout method
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
