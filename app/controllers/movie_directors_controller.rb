class MovieDirectorsController < ApplicationController

    def new
        @movie_director = MovieDirector.new
    end

    def create
        @movie_director = MovieDirector.create(movie_director_params)
    
    end

    private

    def movie_director_params
        params.require(:movie_director).permit(:director_id, :movie_id)
    end
end
