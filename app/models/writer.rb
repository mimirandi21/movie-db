class Writer < ApplicationRecord
    has_many :movie_writers
    has_many :movies, through: :movie_writers
end
