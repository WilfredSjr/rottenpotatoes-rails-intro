class Movie < ActiveRecord::Base
    def self.getRatings
	   return self.pluck(:rating)
    end
end
