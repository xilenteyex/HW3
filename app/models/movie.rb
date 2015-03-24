class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.all_ratings
    @@all_ratings = Movie.uniq.pluck(:rating)
  end

end
