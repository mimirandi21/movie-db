class MovieRatingsController < ApplicationController
    
    def create
        MovieRating.create(movie_rating_params)
    end

    private

    def movie_rating_params
        params.require(:movie_rating).permit(:movie_id, :rating_id)
    end
end