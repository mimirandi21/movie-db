class MovieWritersController < ApplicationController
    
    def create
        MovieWriter.create(movie_writer_params)
    end

    private

    def movie_writer_params
        params.require(:movie_writer).permit(:movie_id, :writer_id)
    end
end