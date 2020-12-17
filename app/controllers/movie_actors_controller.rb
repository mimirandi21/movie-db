class MovieActorsController < ApplicationController

    
    def create
        MovieActor.create(movie_actor_params)
    end
    
        private
    
        def movie_actor_params
            params.require(:movie_actor).permit(:movie_id, :actor_id, :role)
        end
    end
end
