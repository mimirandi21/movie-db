class ApiController < ApplicationController

    def create_movie_from_api

        query = params[:search_id]
        @results_hash, @errors = Imdb::Api.info_search("title/get-overview-details?tconst=", query, clear_cache)

        @movie = Movie.create(
            name: params[:name], 
            poster_url: params[:poster_url],
            length: @results_hash.key?(["title"]) && @results_hash["title"].key?(["runningTimeInMinutes"]) ? @results_hash["title"]["runningTimeInMinutes"] : "",
            plot: @results_hash.key?(["plotOutline"]) && @results_hash["plotOutline"].key?(["text"]) ? @results_hash["plotOutline"]["text"] : "unknown",
            summary: @results_hash.key?(["plotSummary"]) && @results_hash["plotSummary"].key?(["text"]) ? @results_hash["plotSummary"]["text"] : "unknown",
            imdb_link: "www.imdb.com" + params[:search_id]
        )

        self.create_cast_from_api
        self.create_crew_from_api
        self.create_genres_from_api
        self.create_ratings_from_api
        self.create_scores_from_api
        self.create_years_from_api
        @user_movie = UserMovie.create(movie_id: @movie.id, user_id: params[:user_id])
        render 'user_movies/update'
    end

    def create_cast_from_api
        query = params[:search_id]
        actor_hash, @errors = Imdb::Api.cast_search("title/get-overview-details?tconst=", query, clear_cache)
        @cast = []
        i = 0
        while i < 10
            actor_hash = ImdbService.new
            actor_results = actor_hash.get_person_by_imdb(cast_results[i])
            unless !!actor_results["name"]
                @actor = Actor.find_or_create_by(name: actor_results["name"])
                @actor.imdb_link = "www.imdb" + actor_results["id"]
                @actor.img_url = !!actor_results["image"] ? actor_results["image"]["url"] : ""
                MovieActor.create[movie_id: @movie.id, actor_id: @actor.id]
                @cast << @actor
                i += 1
            end
        end
    end

    def create_crew_from_api

        crew_hash = ImdbService.new
        crew_results = crew_hash.get_crew_by_search_id(params[:search_id])
        
        i=0
        while i < 2
            unless !!crew_results["directors"][i]
                @director = Director.find_or_create_by(name: crew_results["directors"][i]["name"])
                @director.imdb_link = "www.imdb" + crew_results["directors"][i]["id"]
                @director.img_url = !!crew_results["directors"][i]["image"] ? crew_results["directors"][i]["image"]["url"] : ""
                MovieDirector.create[movie_id: @movie.id, director_id: @director.id]
                i+=1
            end
        end

        while i < 4
            byebug
            unless crew_results["writer"][i] == false
                @writer = Writer.find_or_create_by(name: crew_results["writers"][i]["name"])
                @writer.imdb_link = "www.imdb" + crew_results["writers"][i]["id"]
                @writer.img_url = i["image"] == false ? crew_results["writers"][i]["image"]["url"] : ""
                MovieWriter.create[movie_id: @movie.id, writer_id: @writer.id]
                i+=1
            end
        end
    end

    def create_genres_from_api
        byebug
        while i < 4
            unless !!@results_hash["genres"][i]
                @genre = Genre.find_or_create_by(name: @results_hash["genres"][i])
                MovieYear.create[movie_id: @movie.id, year_id: @year.id]
                i+=1
            end
        end
    end

    def create_years_from_api
        byebug
        unless !!@results_hash["title"]
            @year = Year.find_or_create_by(year: !!@results_hash["title"]["year"] ? @results_hash["title"]["year"] : "")
            if @year != ""
                MovieYear.create[movie_id: @movie.id, year_id: @year.id]
            end
        end
    end

    def create_ratings_from_api
        byebug
        unless !!@results_hash["certificates"]
            @rating = Rating.find_or_create_by(rating:!!@results_hash["certificates"]["US"][0]["certificate"] ? @results_hash["certificates"]["US"][0]["certificate"] : "unknown")
            if @rating != "unknown"
                MovieRating.create[movie_id: @movie.id, rating_id: @rating.id]
            end
        end
    end

    def create_scores_from_api
        byebug
        unless !!@results_hash["ratings"]
            @score = Score.find_or_create_by(score: !!@results_hash["ratings"]["rating"] ? @results_hash["ratings"]["rating"] : "")
            if @score != ""
                MovieScore.create[movie_id: @movie.id, score_id: @score.id, source: "imdb"]
            end
        end

    end

    private

    def query
        params.fetch(:query, {})
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