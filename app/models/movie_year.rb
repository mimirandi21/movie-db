class MovieYear < ApplicationRecord
    belongs_to :movie
    belongs_to :year
end
