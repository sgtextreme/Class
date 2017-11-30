class SessionsController < ApplicationController
  
  def create
    
    # @user.session_token = @user.generate_session_token
    # session[:session_token] = @user.session_token
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login_user!(user)
      redirect_to session_url
    end
  end 
  
  
  def destroy 
    @user.reset_session_token 
    @user.session_token = nil 
    @user.save!
  end 
  
  def new
    render :new
  end 
  
  
end
