module Imdb
    class Movie < Base

    MAX_LIMIT = 10
    CACHE_DEFAULTS = { expires_in: 3.days, force: false }

      def self.movie_search(query, clear_cache)
          cache = CACHE_DEFAULTS.merge({ force: clear_cache })
          response = MovieRequest.("title/auto-complete?q=", cache, query)
          
          [ response, response[:errors] ]
      end

    end
  end