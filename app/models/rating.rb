class Rating < ApplicationRecord
    has_many :movie_ratings
    has_many :movies, through: :movie_ratings
end
