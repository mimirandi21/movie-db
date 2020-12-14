class Movie < ApplicationRecord
    has_many :collections
    has_many :users, through: :collections
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    has_many :movie_directors
    has_many :directors, through: :movie_directors
    has_many :roles, through: :movie_actors

    accepts_nested_attributes_for :collections
    accepts_nested_attributes_for :actors
    accepts_nested_attributes_for :directors
    accepts_nested_attributes_for :movie_actors
end
