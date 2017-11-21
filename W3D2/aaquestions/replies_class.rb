require 'sqlite3'
require 'singleton'

class Replies
  attr_accessor :id, :body, :parent_reply_id, :user_id, :question_id
  
  def initialize(options)
    @id = options[id]
    @body = options[body]
    @parent_reply_id = options[parent_reply_id]
    @user_id = options[user_id]
    @question_id = options[question_id]
  end 
  
  def self.replies(id) 
    repliers = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      replies
    WHERE 
      id = ?
      
    SQL
    
    Replies.new(repliers.first)  
  end 
  
  def self.find_by_user(user_id) 
    users = QuestionsDatabase.instance.execute(<<-SQL, user_id) 
    
    SELECT
      *
    FROM 
      replies
    WHERE 
      user_id = ?
      
    SQL
    
    Replies.new(users.first)  
  end 
  
  def self.find_by_question(question_id) 
    question = QuestionsDatabase.instance.execute(<<-SQL, question_id) 
    
    SELECT
      *
    FROM 
      replies
    WHERE 
      question_id = ?
      
    SQL
    
    Replies.new(question.first)  
  end 
  
  def author 
    author = QuestionsDatabase.instance.execute(<<-SQL, user_id) 
    
    SELECT 
      fname, lname 
    FROM 
      users 
    WHERE 
      id = self.user_id
    SQL
      
    Replies.new(author.first)  
  end 
  
  def question 
    question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    
    SELECT
      * 
    FROM 
    
    
  
  
end 