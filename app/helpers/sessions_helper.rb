module SessionsHelper 
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  def login_user!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end
end