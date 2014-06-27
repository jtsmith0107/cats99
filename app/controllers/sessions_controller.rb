class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      @user = User.new
      flash[:errors] =  @user.errors.full_messages
      render :new
    else
      login_user!(@user)

      redirect_to cats_url
    end
  end
  
  def destroy
    user = current_user
    self.session[:session_token] = nil
    # user.reset_session_token!
    redirect_to new_session_url
  end
end