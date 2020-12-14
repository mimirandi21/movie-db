class MoviesController < ApplicationController
    before_action :set_movie, only: [:show]

    def new
        @collection = Collection.where(id: params[:collection_id])
        
    end

    def create
        @movie = Movie.new(movie_params)
        hash = ImdbService.new

    end

    def show
        
    end

    def index
        #search only by a user's collection if a user is logged in
        if params[:user_id]
            @movies = Movie.where(user_id: params[:user_id])
            @user = current_user
            @controller = Controller.find_or_create_by(user_id: params[:user_id], movie_id: @movie.id)
        else
            @movies = Movie.all
        end

    end

    def set_movie
        @movie = Movie.find(params[:id])
        puts @movie
    end

    private

    def movie_params
        params.require(:movie).permit(:poster_url, :genre, :year, :name, :plot, :summary, :rating, :score, :length, :director_id,
            actors_attributes: [:name, :imdb_link],
            directors_attributes: [:name, :imdb_link],
            actor_movies_attributes: [:role, :movie_id, :actor_id]    
        )
    end

end
