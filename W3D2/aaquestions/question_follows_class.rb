require 'sqlite3'
require 'singleton'

class Question_follows
  attr_accessor :id, :question_id, :follower_id
  
  def initialize(options)
    @id = options[id]
    @question_id = options[question_id]
    @follower_id = options[follower_id]
  end 
  
  def self.find_by_id(id) 
    followers = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      question_follows
    WHERE 
      id = ?
      
    SQL
    
    Question_follows.new(followers.first)  
  end 
  
end 