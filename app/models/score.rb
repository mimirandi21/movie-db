class Score < ApplicationRecord
    has_many :movie_scores
    has_many :movies, through: :movie_scores
end
