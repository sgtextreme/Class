require 'byebug'

class InsertionError < StandardError; end

class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    if num > @store.count || num < 0
      raise InsertionError.new "Out of bounds"
    end
    @store[num] = true
    
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    
  
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store
  

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num
      @count += 1
    end
    
    if @count >= @store.length
      resize!
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    new_store = Array.new(@store.length*2) { Array.new }
    
    @store = new_store
    # @store = @store*2
    
    @count = 0
    old_store.each_with_index do |el, idx|
      el.each do |val|
        self.insert(val)
      end
    end 
  end
end
