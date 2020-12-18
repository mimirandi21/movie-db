class ApiController < ApplicationController

    def create_movie_from_api

        query = params[:search_id]
        @results_hash, @errors = ImdbService.new.info_search(query, clear_cache)
        if @errors
            render user_path(current_user)
        else
            @movie = Movie.create(
                name: params[:name], 
                poster_url: params[:poster_url],
                length: @results_hash.key?(["title"]) && @results_hash["title"].key?(["runningTimeInMinutes"]) ? @results_hash["title"]["runningTimeInMinutes"] : "",
                plot: @results_hash.key?(["plotOutline"]) && @results_hash["plotOutline"].key?(["text"]) ? @results_hash["plotOutline"]["text"] : "unknown",
                summary: @results_hash.key?(["plotSummary"]) && @results_hash["plotSummary"].key?(["text"]) ? @results_hash["plotSummary"]["text"] : "unknown",
                imdb_link: "www.imdb.com" + params[:search_id]
            )

            while i < 4
                if @results_hash.key?(["genres"]) && @results_hash["genres"].key?([i])
                    @genre = Genre.find_or_create_by(name: @results_hash["genres"][i])
                    MovieGenre.create[movie_id: @movie.id, genre_id: @genre.id]
                    i+=1
                end
            end

            if @results_hash.key?(["title"]) && @results_hash["title"].key?(["year"])
                @year = Year.find_or_create_by(year: @results_hash["title"]["year"])
            else
                @year = Year.find_or_create_by(year: "unknown")
            end
            MovieYear.create[movie_id: @movie.id, year_id: @year.id]

            if @results_hash.key?(["certificates"]) && @results_hash["certificates"].key?(["US"]) && @results_hash["certificates"]["US"].key?([0]) && @results_hash["certificates"]["US"][0].key?(["certificate"])
                @rating = Rating.find_or_create_by(rating: @results_hash["certificates"]["US"][0]["certificate"])
            else
                @rating = Rating.find_or_create_by(rating: "unknown")
            end
            MovieRating.create[movie_id: @movie.id, rating_id: @rating.id]
            
            if @results_hash.key?(["ratings"]) && @results_hash["ratings"].key?(["rating"])
                @score = Score.find_or_create_by(score: @results_hash["ratings"]["rating"])
                MovieScore.create[movie_id: @movie.id, score_id: @score.id, source: "imdb"]
            end

            self.create_cast_from_api
            self.create_crew_from_api
            @user_movie = UserMovie.create(movie_id: @movie.id, user_id: params[:user_id])
            render 'user_movies/update'
        end
    end

    def create_cast_from_api
        query = params[:search_id]
        actor_hash, @errors = ImdbService.new.cast_search(query, clear_cache)

        if @errors
            render user_path(current_user)
        else
            @cast = []
            i = 0
            while i < 10
                query = actor_hash[i]
                actor_results, @errors = ImdbService.new.person_search(query, clear_cache)
                if @errors
                    render user_path(current_user)
                else
                    if actor_results.key?(["name"])
                        @actor = Actor.find_or_create_by(name: actor_results["name"])
                        @actor.imdb_link = actor_results.key?(["id"] ? "www.imdb" + actor_results["id"] : ""
                        @actor.img_url = actor_results.key?(["image"]) && actor_results["image"].key?(["url"]) ? actor_results["image"]["url"] : ""
                        MovieActor.create[movie_id: @movie.id, actor_id: @actor.id]
                        @cast << @actor
                        i += 1
                    end
                end
            end
        end
    end

    def create_crew_from_api

        query = params[:search_id]
        crew_results, @errors = ImdbService.new.crew_search(query, clear_cache)
        
        if @errors
            render user_path(current_user)
        else
            i=0
            while i < 1
                if crew_results["directors"].key?([i])
                    @director = Director.find_or_create_by(name: crew_results["directors"][i]["name"])
                    @director.imdb_link = crew_results["directors"][i].key?(["id"]) ? "www.imdb" + crew_results["directors"][i]["id"] : ""
                    @director.img_url = crew_results["directors"][i].key?(["image"]) && crew_results["directors"][i]["image"].key?(["url"]) ? crew_results["directors"][i]["image"]["url"] : ""
                    MovieDirector.create[movie_id: @movie.id, director_id: @director.id]
                    i+=1
                end
            end

            while i < 4
                byebug
                unless crew_results["writer"].key?([i])
                    @writer = Writer.find_or_create_by(name: crew_results["writers"][i]["name"])
                    @writer.imdb_link = crew_results["writers"][i].key?(["id"]) ? "www.imdb" + crew_results["writers"][i]["id"] : ""
                    @writer.img_url = crew_results["writers"][i].key?(["image"]) && crew_results["writers"][i]["image"].key?(["url"]) ? crew_results["writers"][i]["image"]["url"] : ""
                    MovieWriter.create[movie_id: @movie.id, writer_id: @writer.id]
                    i+=1
                end
            end
        end
    end


    private


    def clear_cache
        params[:clear_cache].present?
    end

    def refresh_params
        refresh = { clear_cache: true }
        refresh.merge!({ query: query }) if query.present?
        refresh
    end


end