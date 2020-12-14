class MovieActorsController < ApplicationController

    def new
        @movie_actor = MovieActor.new
    end

    def create
        @movie_actor = MovieActor.create(movie_actor_params)
        hash = ImdbService.new
    end

    private

    def movie_actor_params
        params.require(:movie_actor).permit(:actor_id, :movie_id, :role)
    end
end
