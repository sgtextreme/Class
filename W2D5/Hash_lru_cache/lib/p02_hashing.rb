class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    index = self.reduce{|n, d| n*10 + d}
    index.hash
  end
end

class String
  def hash
    ord_chars = []
    self.chars.each do |char|
      ord_chars << char.ord
    end
    ord_reduce = ord_chars.reduce{|n, d| n*10 + d}
    ord_reduce.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hasher = 0 
    # self.each do |k,v| 
    #   if v.is_a?(String)
    #     v.chars.each do |char|
    #       hasher += char.ord
    #     end
    #   end
    #   if k.is_a?(String)
    #     v.chars.each do |char|
    #       hasher += char.ord
    #   else 
    #   v.each do 
    #   hasher += k.ord + v.ord 
    
    hash_arr = self.to_a 
    hash_arr.flatten.each do |el|
      if el.is_a?(String)
        el.chars.each do |char|
          hasher += char.ord
        end 
      elsif el.is_a?(Symbol)
        hasher+= el.object_id
      else
        hasher += el 
      end 
    end 
    hasher.hash
    
    
    hasher.hash
  end
end
