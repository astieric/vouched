module TermsHelper

# Poor man's keyword extractor

  def extract_terms text
    words = text.downcase.scan(/\w+/)
 
    one_grams = Hash.new(0) # hash returns a value of zero if key not present 
    bi_grams = Hash.new(0) 
    tri_grams = Hash.new(0) 
 
    num = words.length 
    num.times do |i| 
      one_grams[words[i]] += 1 
      if i < (num - 1) 
         bi = words[i] + ' ' + words[i+1] 
         bi_grams[bi] += 1 
         if i < (num - 2) 
            tri = bi + ' ' + words[i+2] 
            tri_grams[tri] += 1 
         end 
      end 
    end

    Term.where("LOWER(terms.name) IN ( #{(one_grams.to_a + bi_grams.to_a + tri_grams.to_a).collect{|w| "'" + w[0] + "'"}.join(',')})")
  end
  
end
