class User < ApplicationRecord
  
  
  attr_accessor :password 
  
  
  def generate_session_token 
    
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    render = new 
  
  end
  
  def reset_session_token 
    
  self.session_token = nil 
  self.session_token = SecureRandom.urlsafe_base(16)
  self.save!
  
  end 
  
  
  def ensure_session_token
    
    
    
  end 
  
  
  def password=(password)
    
    self.password = password 
    self.digest_password = Bcrypt::Password.create(passowrd)
    
  end
  
  def is_password(password)
    
    # password_check_digest = Bcrypt::Password.create(password)
    # self.digest_password == password_check_digest 
    
    Bcrypt::Password.new(self.password_digest).is_password?(password)
    
  end 
  
  def find_by_credentials(email, password)
    
    user = User.find_by_email(email) 
    
  end 
  
  
    
  





end
