class Year < ApplicationRecord
    has_many :movie_years
    has_many :movies, through: :movie_years
end
