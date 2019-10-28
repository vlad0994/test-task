module SessionsHelper
  def sign_in(user)
    cookies.permanent[:user_key] = user.key
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  attr_writer :current_user

  def current_user
    @current_user ||= User.find_by(key: cookies[:user_key])
  end
end