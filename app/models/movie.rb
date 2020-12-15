class Movie < ApplicationRecord
    has_many :user_movies
    has_many :users, through: :user_movies
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    has_many :movie_directors
    has_many :directors, through: :movie_directors
    has_many :roles, through: :movie_actors

    accepts_nested_attributes_for :user_movies
    accepts_nested_attributes_for :actors
    accepts_nested_attributes_for :directors
    accepts_nested_attributes_for :movie_actors
    accepts_nested_attributes_for :movie_directors
end
