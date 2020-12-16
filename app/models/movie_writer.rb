class MovieWriter < ApplicationRecord
    belongs_to :movie
    belongs_to :writer

end
