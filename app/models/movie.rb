class Movie < ActiveRecord::Base
    def self.ratings
	   return self.pluck(:rating)
    end
end
