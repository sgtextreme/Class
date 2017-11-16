require 'byebug'


def bad_two_sum?(arr, target) # O(n^2)
  arr.each_with_index do |el, i|
    arr.each_with_index do |el2, j|
      if i == j
        next
      else
        return true if el + el2 == target
      end
    end
  end
  false
end

def okay_two_sum?(arr, target) # O(n^2)
  arr = arr.sort 
  arr.each do |el|
    
    difference = target - el 
    a = arr.bsearch{|el| el == difference}
    if a != nil
      return true
    end 
    a = nil 
  end
  false 
  # new_arr = arr.sort.select {|el| el < target}
  # new_arr.each_with_index do |el, idx|
  #   new_arr.each_with_index do |el2, idx2|
  #     next if idx == idx2
  #     return true if el + el2 == target
  #   end
  # end
  # false
end

def two_sum?(arr, target)
  hasher = Hash.new 
  
  
  
  
  

  arr.each_with_index do |el, idx| #2n
    hasher[el] = target - el 
  end 
  
  hasher.each do |k,v|
  return true if hasher.has_key?(v) && hasher[v] != v
  end
  
  
  
  # hasher.each do |k1,v1|
  #   hasher.each do |k2,v2|
  #     next if k1 == k2
  #   return true if hasher[k1] + hasher[k2] == target
  #   end
  # end 
   false
end 