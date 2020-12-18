class MoviesController < ApplicationController
    before_action :set_movie, only: [:show]

    def new
        @movie = Movie.new
    end

    def create
        input = params[:name].titleize
        @movies = Movie.where( 'name like ?', '%' + input + '%' )
        if !@movies.empty?
            @movies = Movie.where( 'name like ?', '%' + input + '%' )
            render :choose
        else
            query = params[:name].titleize
            new_search = ImdbService.new
            results, @errors = new_search.movie_search(query, clear_cache)
            if @errors
                render user_path(current_user)
            else
                @movies = []
                i=0
                while i < results.length
                    if results.key?([i])
                        @movies << [results[i].key?(["l"]) ? results[i]["l"] : '', results[i].key?(["id"]) ? results[i]["id"] : '', results[i].key?(["i"]) && results[i]["i"].key?(["imageUrl"]) ? results[i]["i"]["imageUrl"] : '']
                    end
                end
                session[:movies] = @movies
                redirect_to apichoose_path(current_user)
            end
        end
    end

    def create_from_db
        @user_movie = UserMovie.new(user_id: current_user.id, movie_id: params[:movie_id])
        redirect_to update_user_movie(@user_movie.id)
    end

    # def create_from_api

    #     query = params[:search_id]
    #     results = Imdb::Movie.find("title/get-overview-details?tconst=", query, clear_cache)

    #     movies = response.fetch('d', []).map { |movie| movie.key?["l"] ? ["l"] : '', movie.key?["id"] ? ["id"] : '', movie.key?("i") ? ["i"]["imageUrl"] : ''}
    #     [ movies, response[:errors] ]

    #     @movie = Movie.new(
    #         name: params[:name], 
    #         poster_url: params[:poster_url],
    #         length: !results_hash["title"]["runningTimeInMinutes"].nil? ? results_hash["title"]["runningTimeInMinutes"] : "",
    #         plot: !results_hash["plotOutline"]["text"].nil? ? results_hash["plotOutline"]["text"] : "unknown",
    #         summary: !results_hash["plotSummary"]["text"].nil? ? results_hash["plotSummary"]["text"] : "unknown",
    #         imdb_link: "www.imdb.com" + results_hash["title"]["id"]
    #     )
    #     @user_movie = UserMovie.create(movie_id: @movie.id, user_id: params[:user_id])

    #     #create or find rating
    #     @rating = Rating.find_or_create_by(rating: !results_hash["certificates"]["US"][0]["certificate"].nil? ? results_hash["certificates"]["US"][0]["certificate"] : "unknown")
    #     if @rating != "unknown"
    #         MovieRating.create[movie_id: @movie.id, rating_id: @rating.id]
    #     end

    #     #create or find score/ create moviescore
    #     @score = Score.find_or_create_by(score: !results_hash["ratings"]["rating"].nil? ? results_hash["ratings"]["rating"] : "")
    #     if @score != ""
    #         MovieScore.create[movie_id: @movie.id, score_id: @score.id, source: "imdb"]
    #     end

    #     #create or find year/ create movieyear
    #     @year = Year.find_or_create_by(year: !results_hash["title"]["year"].nil? ? results_hash["title"]["year"] : "")
    #     if @year != ""
    #         MovieYear.create[movie_id: @movie.id, year_id: @year.id]
    #     end

    #     #create or find genres/ create moviegenres
    #     for i in results_hash["genres"]
    #         @genre = Genre.find_or_create_by(name: i)
    #         MovieYear.create[movie_id: @movie.id, year_id: @year.id]
    #     end

    #     crew_hash = ImdbService.new
    #     crew_results = crew_hash.get_crew_by_search_id(params[:search_id])

    #     for i in crew_results["directors"]
    #         @director = Director.find_or_create_by(name: i["name"])
    #         @director.imdb_link = "www.imdb" + i["id"]
    #         @director.img_url = !i["image"].nil? ? i["image"]["url"] : ""
    #         MovieDirector.create[movie_id: @movie.id, director_id: @director.id]
    #     end

    #     for i in crew_results["writers"]
    #         @writer = Writer.find_or_create_by(name: i["name"])
    #         @writer.imdb_link = "www.imdb" + i["id"]
    #         @writer.img_url = !i["image"].nil? ? i["image"]["url"] : ""
    #         MovieWriter.create[movie_id: @movie.id, writer_id: @writer.id]
    #     end

    #     cast_hash = ImdbService.new
    #     cast_results = cast_hash.get_cast_by_search_id(params[:search_id])

        
    #     for i in cast_results
    #         byebug
    #             actor_hash = ImdbService.new
    #             actor_results = actor_hash.get_person_by_imdb(i)
    #             @actor = Actor.find_or_create_by(name: actor_results["name"])
    #             @actor.imdb_link = "www.imdb" + actor_results["id"]
    #             @actor.img_url = !actor_results["image"].nil? ? actor_results["image"]["url"] : ""
    #             MovieActor.create[movie_id: @movie.id, actor_id: @actor.id]
            
    #     end

    #     render 'user_movies/update'
    # end

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
        params.require(:movie).permit(:poster_url, :imdb_link, :genre, :year, :name, :plot, :summary, :rating, :score, :length, :director_id, :search_id, :stars,
            actors_attributes: [:name, :imdb_link],
            directors_attributes: [:name, :imdb_link],
            movie_actor_attributes: [:role, :movie_id, :actor_id],
            genre_attributes: [:name],
            year_attributes: [:year],
            rating_attributes: [:rating],
            score_attributes: [:score],
            movie_score_attributes: [:source]  
        )
    end


    def clear_cache
        params[:clear_cache].present?
    end

    def refresh_params
        refresh = { clear_cache: true }
        refresh.merge!({ query: query }) if query.present?
        refresh
    end

end
