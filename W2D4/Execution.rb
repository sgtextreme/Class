
arr = [0,3,5,4,-5,10,1,90]
def my_min(list)
  output = 0
  list.each do |el|
    output = el if el < output
  end
  output
end

my_min(arr) == -5 # Time complexity == O(n)

def largest_contiguous_subsum(list)
  subs = []
  list.each_with_index do |el, idx|
      list.each_with_index do |el2, idx2|
      # (idx...list.length).to_a.each_index do |idx2|
      subs << list[idx..idx2] unless list[idx..idx2] == []
    end
  end
  
  sums = subs.map {|el| el.reduce(:+)}
  p sums
  sums.max
end

def largest_contiguous_subsum_n1(list)
  current = list.first
  max = list.first
  list.each_with_index do |el,idx|
    next if idx == 0 
    current += el
    if current > max  
      max = current
    elsif current < 0 
      current = 0 
    end
  end
  max
end 