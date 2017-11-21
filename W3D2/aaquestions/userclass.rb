require 'sqlite3'
require 'singleton'

class User 


  def initialize(questions)
    @id = options[:id]
    @fname = options[:fname]
    @lname = options[:lname]
  end 
  
  def self.find_by_id(id) 
    user = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      user
    WHERE 
      id = ?
      
    SQL
    
    User.new(user.first)  
  end 
  
  def self.find_by_id(fname, lname) 
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname) 
    
    SELECT
      *
    FROM 
      user
    WHERE 
      fname = ? AND lname = ?
      
    SQL
    
    User.new(user.first)  
  end 
  
  def authored_questions
  
    Question.find_by_author_id(self.id)
     
  end 
  
  def authored_replies
    Replies.find_by_user_id(self.id)
  end 
  
end 