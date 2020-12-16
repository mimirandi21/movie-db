class MovieScore < ApplicationRecord
    belongs_to :movie
    belongs_to :score
end
