class GenresController < ApplicationController
    
    def create
        Genre.create(genre_params)
    end

    private

    def genre_params
        params.require(:genre).permit(:name)
    end
end