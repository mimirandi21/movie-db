class MovieScoresController < ApplicationController
    
    def create
        MovieScore.create(movie_score_params)
    end

    private

    def movie_score_params
        params.require(:movie_score).permit(:movie_id, :score_id)
    end
end