# PHASE 2
require "byebug"
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError, TypeError
    # if Integer(str).class != FixNum
    -1
    # end
  end
end

# PHASE 3
class CoffeeReactionError < StandardError; end
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeReactionError
  else
    raise StandardError
  end
end

def feed_me_a_fruit

  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
rescue CoffeeReactionError
  puts "Thanks for the coffee"
  retry
end

# PHASE 4
class NonBestFriend < StandardError
  def my_message
    puts "Not my best friend!"
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @fav_pastime = fav_pastime

    @yrs_known = yrs_known

    begin
      if yrs_known < 5
        self.class.new_best_friend
      end
    rescue NonBestFriend => bestie
      bestie.my_message
      retry
    end

  end

  def self.new_best_friend

    p 'who is your best friend'
    @name = gets.chomp
    p 'favorite past time?'
    @fav_pastime = gets.chomp
    p "Years known him/her?"
    @yrs_known = gets.chomp.to_i
    if @yrs_known < 5
      debugger
      raise NonBestFriend
    end
    # BestFriend.new(@name,@yrs_known,@fav_pastime)

  end


  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
