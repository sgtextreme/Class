require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
  
    if !self[key].include?(key)
      
      self[key] << key
        # p self[key]
        # p@store
      @count += 1
    end
    
    if @count >= @store.length
      resize!
    end
  end

  def include?(key)
    self[key].include?(key)
    
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
