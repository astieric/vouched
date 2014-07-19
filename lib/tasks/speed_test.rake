

namespace :speedtest do 
  require 'benchmark'

  desc "Test Speed of finding strings in text"
  task :test => :environment do


    text = "Ruby on Rails is neat, but I wish it was  much much faster than it is now.  Python is a similar language but not as fast as Java or Haskell."
   # self.connection.execute("SELECT name FROM Terms"

    terms = Term.all

      Benchmark.bm do |x|

        x.report("use the db") {
          puts "\nIn the Database\n"
          text2 = text.scan(/\w+/)

          words = Hash.new(0)
          num = text2.length 
          num.times do |i|
            words[text2[i]] += 1 
          end
          puts Term.where(:name => words.collect{|w| w[0]}).all
	}

       x.report("n-grams in the db") {
          puts "\nn-Grams In the Database\n"
          words = text.scan(/\w+/)

          one_grams = Hash.new(0) # hash returns a value of zero if key not present 
          bi_grams  = Hash.new(0) 
          tri_grams = Hash.new(0) 
 
          num = words.length 
          num.times {|i| 
            one_grams[words[i]] += 1 
            if i < (num - 1) 
               bi = words[i] + ' ' + words[i+1] 
               bi_grams[bi] += 1 
               if i < (num - 2) 
                  tri = bi + ' ' + words[i+2] 
                  tri_grams[tri] += 1 
               end 
            end 
          }

          puts Term.where(:name => one_grams.collect{|w| w[0]} + bi_grams.collect{|w| w[0]} + tri_grams.collect{|w| w[0]} ).all
	}

        x.report("scan") { 
          puts "\nScanning\n"

          terms.each do |t|
            text.scan(t.name) {|m| puts m}
          end
	 }

        x.report("match") {
          puts "\nMatching\n"
 
          terms.each do |t|
            text.match(Regexp.escape(t.name)) {|m| puts m}
          end
	 }

        x.report("include?") { 
          puts "\nInclude\n"

          terms.each do |t|
             if text.include? t.name
               puts t.name
             end
          end
	 }
      end

  end
end

