class Movie < ActiveRecord::Base
    def self.ratings
        array = Array.new
        self.select("rating").uniq.each{|x| a.push(x.rating)}
        a.sort.uniq
    end
end
