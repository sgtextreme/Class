class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :log_in_user! 

  
  
  private
  
  def current_user 
    
    @current_user||=User.find_by_session_token(session[:session_token])
    
  end  
  
  def logged_in?
    # if @current_user.session_token == session[:session_token]
    #   return true 
    # end 
    # false 
    # 
    
    !current_user.nil?
  end 
  
  
  def log_in_user!(user)
    
    session[:session_token] = current_user.reset_session_token!
    
  end 
  

end
