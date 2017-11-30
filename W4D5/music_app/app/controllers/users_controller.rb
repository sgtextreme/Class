class UsersController < ApplicationController
  
  
  def create
    
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url 
    else  
      flash.now[:errors] = @user.errors.full_messages
      # redirect_to 
      render :new 
    end 
  end
  
  def new 
    @user = User.new 
    render :new 
  end  
  
  def show 
    render :new 
    
  end 
  private
  
  
  
  
  def user_params
    params.require(:email,:password)
    
  end 
end
