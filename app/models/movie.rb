class Movie < ApplicationRecord
    has_many :user_movies
    has_many :users, through: :user_movies
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    has_many :movie_directors
    has_many :directors, through: :movie_directors
    has_many :roles, through: :movie_actors
    has_many :movie_genres
    has_many :genres, through: :movie_genres
    has_many :movie_years
    has_many :years, through: :movie_years
    has_many :movie_ratings
    has_many :ratings, through: :movie_ratings
    has_many :movie_scores
    has_many :scores, through: :movie_scores
    has_many :movie_writers
    has_many :writers, through: :movie_writers

    accepts_nested_attributes_for :user_movies
    accepts_nested_attributes_for :actors
    accepts_nested_attributes_for :directors
    accepts_nested_attributes_for :movie_actors
    accepts_nested_attributes_for :movie_directors
    accepts_nested_attributes_for :genres
    accepts_nested_attributes_for :scores
    accepts_nested_attributes_for :ratings
    accepts_nested_attributes_for :years
    accepts_nested_attributes_for :movie_scores
end
