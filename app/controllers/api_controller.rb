class ApiController < ApplicationController

    def create_movie_from_api
        hash = ImdbService.new
        @results_hash = hash.get_info_by_search_id(params[:search_id])
        @movie = Movie.create(
            name: params[:name], 
            poster_url: params[:poster_url],
            length: !@results_hash["title"]["runningTimeInMinutes"].nil? ? @results_hash["title"]["runningTimeInMinutes"] : "",
            plot: !@results_hash["plotOutline"]["text"].nil? ? @results_hash["plotOutline"]["text"] : "unknown",
            summary: !@results_hash["plotSummary"]["text"].nil? ? @results_hash["plotSummary"]["text"] : "unknown",
            imdb_link: "www.imdb.com" + results_hash["title"]["id"]
        )
        @user_movie = UserMovie.create(movie_id: @movie.id, user_id: params[:user_id])

        self.create_cast_from_api
        self.create_crew_from_api
        self.create_genres_from_api
        self.create_ratings_from_api
        self.create_scores_from_api
        self.create_years_from_api
        self.create_user_associations_from_api
        render 'user_movies/update'
    end

    def create_cast_from_api
        cast_hash = ImdbService.new
        @cast_results = cast_hash.get_cast_by_search_id(params[:search_id])
        
        i = 0
        for i in @cast_results while i <=10
            actor_hash = ImdbService.new
            actor_results = actor_hash.get_person_by_imdb(i)
            @actor = Actor.find_or_create_by(name: actor_results["name"])
            @actor.imdb_link = "www.imdb" + actor_results["id"]
            @actor.img_url = !actor_results["image"].nil? ? actor_results["image"]["url"] : ""
            MovieActor.create[movie_id: @movie.id, actor_id: @actor.id]
        end
    end

    def create_crew_from_api

        crew_hash = ImdbService.new
        crew_results = crew_hash.get_crew_by_search_id(params[:search_id])

        for i in crew_results["directors"]
            @director = Director.find_or_create_by(name: i["name"])
            @director.imdb_link = "www.imdb" + i["id"]
            @director.img_url = !i["image"].nil? ? i["image"]["url"] : ""
            MovieDirector.create[movie_id: @movie.id, director_id: @director.id]
        end

        for i in crew_results["writers"]
            @writer = Writer.find_or_create_by(name: i["name"])
            @writer.imdb_link = "www.imdb" + i["id"]
            @writer.img_url = !i["image"].nil? ? i["image"]["url"] : ""
            MovieWriter.create[movie_id: @movie.id, writer_id: @writer.id]
        end
    end

    def create_genres_from_api
        for i in @results_hash["genres"]
            @genre = Genre.find_or_create_by(name: i)
            MovieYear.create[movie_id: @movie.id, year_id: @year.id]
        end
    end

    def create_years_from_api
        @year = Year.find_or_create_by(year: !@results_hash["title"]["year"].nil? ? @results_hash["title"]["year"] : "")
        if @year != ""
            MovieYear.create[movie_id: @movie.id, year_id: @year.id]
        end
    end

    def create_ratings_from_api
        @rating = Rating.find_or_create_by(rating: !@results_hash["certificates"]["US"][0]["certificate"].nil? ? @results_hash["certificates"]["US"][0]["certificate"] : "unknown")
        if @rating != "unknown"
            MovieRating.create[movie_id: @movie.id, rating_id: @rating.id]
        end
    end

    def create_scores_from_api
        @score = Score.find_or_create_by(score: !@results_hash["ratings"]["rating"].nil? ?@results_hash["ratings"]["rating"] : "")
        if @score != ""
            MovieScore.create[movie_id: @movie.id, score_id: @score.id, source: "imdb"]
        end
    end

    def create_user_associations_from_api
        
    end

end