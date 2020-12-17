class MovieYearsController < ApplicationController
    
    def create
        MovieYear.create(movie_year_params)
    end

    private

    def movie_year_params
        params.require(:movie_year).permit(:movie_id, :year_id)
    end
end