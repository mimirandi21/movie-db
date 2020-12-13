class Movie < ApplicationRecord
    has_many :collections
    has_many :users, through: :collections
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    belongs_to :director
    has_many :roles, through: :movie_actors
end
