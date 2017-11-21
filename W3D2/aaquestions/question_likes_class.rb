require 'sqlite3'
require 'singleton'

class Question_likes
  attr_accessor :id, :liked_q_id, :user_that_liked_id
  
  def initialize(options)
    @id = options[id]
    @liked_q_id = options[liked_q_id]
    @user_that_liked_id = options[user_that_liked_id]
  end 
  
  def self.question_likes(id) 
    liked = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      question_likes
    WHERE 
      id = ?
      
    SQL
    
    question_likes.new(liked.first)  
  end 
  
end 