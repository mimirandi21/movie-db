class MoviesController < ApplicationController
    before_action :set_movie, only: [:show]

    def new
        @movie = Movie.new
    end

    def create
        input = params[:name].downcase
        @movies = Movie.where( 'name like ?', '%' + input + '%' )
        if !@movies.empty?
            render :choose
        else
            hash = ImdbService.new
            results_hash = hash.get_movie_by_name(params[:name])
            
            @result1 = [results_hash["d"][0]["l"], results_hash["d"][0]["id"], results_hash["d"][0]["i"]["imageUrl"], results_hash["d"][0]["s"]],
            @result2 = [results_hash["d"][1]["l"], results_hash["d"][1]["id"], results_hash["d"][1]["i"]["imageUrl"], results_hash["d"][1]["s"]],
            @result3 = [results_hash["d"][2]["l"], results_hash["d"][2]["id"], results_hash["d"][2]["i"]["imageUrl"], results_hash["d"][2]["s"]],
            @result4 = [results_hash["d"][3]["l"], results_hash["d"][3]["id"], results_hash["d"][3]["i"]["imageUrl"], results_hash["d"][3]["s"]],
            @result5 = [results_hash["d"][4]["l"], results_hash["d"][4]["id"], results_hash["d"][4]["i"]["imageUrl"], results_hash["d"][4]["s"]],
            @result6 = [results_hash["d"][5]["l"], results_hash["d"][5]["id"], results_hash["d"][5]["i"]["imageUrl"], results_hash["d"][5]["s"]],
            @result7 = [results_hash["d"][6]["l"], results_hash["d"][6]["id"], results_hash["d"][6]["i"]["imageUrl"], results_hash["d"][6]["s"]]
            
            render :choose
        end
    end

    def create_from_db

    end

    def create_from_api
        @movie = Movie.new(movie_params)

    end

    def show
        @movie = Movie.find_by(id: params[:id])
        @user_movie = UserMovie.find_by(movie_id: params[:id])
    end

    def index
        #search only by a user's collection if a user is logged in
        if logged_in?
            @movies = Movie.all
            @user = current_user
            @user_movies = UserMovie.where(user_id: params[:user_id])
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
