require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database 
  include Singleton 
  
  def initialize 
    super('questions.db')
    self.results_as_hash = true 
  end
end 

class Users < SQLite3::Database 
  
  def initialize(options)
    @id = options[:id]
    @fname = options[:fname]
    @lname = options[:lname]
  end 
  
  def self.find_by_id(id) 
    user = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      users
    WHERE 
      id = ?
      
    SQL
    if user.first != nil 
      Users.new(user.first)  
    end 
  end 
  
  def self.find_by_name(fname, lname) 
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname) 
    
    SELECT
      *
    FROM 
      users
    WHERE 
      fname = ? AND lname = ?
      
    SQL
    if users.first != nil 
      Users.new(user.first)
    end   
  end 
  
  def authored_questions
  
    Question.find_by_author_id(self.id)
     
  end 
  
  def authored_replies
    Replies.find_by_user_id(self.id)
  end 
  
end 
  
  
class Question
  attr_accessor :id, :title, :body, :author_id
  
  def initialize(options)
    @id = options[:id]
    @title = options[:title]
    @body = options[:body]
    @author_id = options[:author_id]
  end 
  
  def self.find_by_id(id) 
    question = QuestionsDatabase.instance.execute(<<-SQL, id) 
    
    SELECT
      *
    FROM 
      questions 
    WHERE 
      id = ?
      
    SQL
    if question.first != nil 
      Question.new(question.first)  
    end 
  end 
  
  def self.find_by_author(author_id)
    author = QuestionsDatabase.instance.execute(<<-SQL, author_id) 
    
    SELECT
      *
    FROM 
      questions 
    WHERE 
      author_id = ?
      
    SQL
    if author.first != nil 
      Question.new(author.first)
    end   
  end 
  
  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, author_id) 
    
    SELECT 
      fname, lname 
    FROM 
      users 
    WHERE 
      id = self.author_id
    SQL
    if author.first != nil 
      Question.new(author.first)
    end   
  end 
  
  def replies 
    Reply.find_by_question_id(self.id)
  end 
  
end 

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
    if followers.first != nil 
      Question_follows.new(followers.first)  
    end 
  end 
  
  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL) 
    SELECT 
      *
    FROM 
      question_follows 
    JOIN users
      ON question_follows.follower_id = users.id
    SQL
  end
  
  def self.followed_questions_for_user_id(user_id)
    followed = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT 
      
    FROM 
      questions 
    JOIN question_follows ON question_follows.question_id = questions.id
    JOIN users ON 
    SQL
  end 
end 

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
    if repliers.first != nil 
      Replies.new(repliers.first)  
    end 
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
    if users.first != nil 
      Replies.new(users.first)  
    end 
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
    if question.first != nil 
      Replies.new(question.first)  
    end 
  end 
  
  def author 
    author = QuestionsDatabase.instance.execute(<<-SQL) 
    
    SELECT 
      fname, lname 
    FROM 
      users 
    WHERE 
      id = #{self.user_id}
    SQL
    if author.first != nil   
      Replies.new(author.first)  
    end 
  end 
  
  def question 
    question = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM 
      questions 
    WHERE 
      id = #{self.question_id}
    SQL
    if question.first != nil 
      Replies.new(question.first) 
    end  
  end 
  
  def parent_reply 
    reply = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT 
      *
    FROM 
      replies 
    WHERE 
      id = #{self.parent_reply_id}
    SQL
    if reply.first != nil 
      Replies.new(reply.first)
    end 
  end 
  
  def child_replies 
    reply = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT 
      *
    FROM 
      replies 
    WHERE 
      parent_reply_id != nil 
    SQL
    if reply.first != nil 
      Replies.new(reply.first)
    end 
  end 

end 


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
    if liked.first != nil 
      Question_likes.new(liked.first)  
    end 
  end 
  
end 




