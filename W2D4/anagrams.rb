
def first_anagram?(string1, string2) #O(n!*n)
  perm1 = string1.split('').permutation.to_a
  perm1 = perm1.map{ |word| word.join('') }
  return true if perm1.include?(string2)
  false
end

def second_anagram?(string1, string2) #O(n^2)
  str1dup = string1.dup.split('')
  str2dup = string2.dup.split('')
  string1.split('').each_with_index do |el, idx|
    string2.split('').each_with_index do |el2, idx2|
      if el == el2
        str1dup.delete(el)
        str2dup.delete(el2)
      end
    end  
  end    
  return true if str1dup.length == 0 && str2dup.length == 0 
  false
end

def third_anagram?(string1, string2) # O(nlog(n))
  return true if string1.sort == string2.sort
  false
end

def fourth_anagram?(string1, string2) #O(n)
  word_hash1 = Hash.new { |hash, key| hash[key] = 0 }
  word_hash2 = Hash.new { |hash, key| hash[key] = 0 }
  hash1 = string1.split('').map {|el| word_hash1[el] += 1}
  hash2 = string2.split('').map {|el| word_hash2[el] += 1}
  return true if word_hash1 == word_hash2
  false
end