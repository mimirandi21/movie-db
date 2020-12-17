class MovieGenresController < ApplicationController
    
    def create
        MovieGenre.create(movie_genre_params)
    end

    private

    def movie_genre_params
        params.require(:movie_genre).permit(:movie_id, :genre_id)
    end
end