class MoviesController < ApplicationController
    before_action :set_movie, only: [:show]

    def new
        @movie = Movie.new
    end

    def create
        input = params[:name].upcase
        @movies = Movie.where("name LIKE ?", "%" + input + "%")
        if @movies = true
            redirect_to choose_path(session[:user_id])
        else
            :choose_from_api
        end
    end

    def create_from_db

    end

    def choose_from_api
        hash = ImdbService.new
        hash.get_movie_by_name(params[:name])
    end

    def create_from_api
        @movie = Movie.new(movie_params)

    end

    def show
        
    end

    def index
        #search only by a user's collection if a user is logged in
        if params[:user_id]
            @movies = Movie.where(user_id: params[:user_id])
            @user = current_user
            @user_movie = UserMovie.find_or_create_by(user_id: params[:user_id], movie_id: @movie.id)
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
        params.require(:movie).permit(:poster_url, :imdb_link, :genre, :year, :name, :plot, :summary, :rating, :score, :length, :director_id,
            actors_attributes: [:name, :imdb_link],
            directors_attributes: [:name, :imdb_link],
            actor_movies_attributes: [:role, :movie_id, :actor_id]    
        )
    end

end
