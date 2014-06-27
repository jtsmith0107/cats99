class UsersController < ApplicationController
  before_action :not_logged_in, :only => [:create, :new]
  def new
    @user = User.new
    render :new
  end

  def create
 
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] =  @user.errors.full_messages
      render :new
    end
  end
  
  def index
    @users = User.all
    render :index
  end
  
  
  private
  
  def not_logged_in
    # fail
    unless current_user.nil?       
      # (self.flash()).[]=(:errors, ["You cannot create..."])      
      flash[:errors] = ["You cannot create a new user while logged in"]
      redirect_to cats_url # halts request cycle
     end
   end
  
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end