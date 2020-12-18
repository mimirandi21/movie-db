class ImdbService
    require 'faraday'
    require 'json'
    # class Api < Base

    MAX_LIMIT = 10
    CACHE_DEFAULTS = { expires_in: 3.days, force: false }

    def movie_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        response = self.search("title/auto-complete?q=", cache, query)
        
        [ response, response[:errors] ]
    end

    def info_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = self.search("title/get-overview-details?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def cast_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = self.search("title/get-top-cast?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def crew_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = self.search("title/get-top-crew?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def person_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = self.search("actors/get-bio?nconst=", cache, query)
        [ results, response[:errors] ]
    end

    def search(resource_path, cache, query)
        response, status = get_json(resource_path, cache, query)
        status == 200 ? response : errors(response)
    end

    def get(id, cache)
        response, status = get_json(id, cache)
        status == 200 ? response : errors(response)
    end

    def errors(response)
        error = { errors: { status: response["status"], message: response["message"] } }
        response.merge(error)
    end

    def api
        base = ("https://imdb8.p.rapidapi.com/")
        Faraday.new(url: base) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def get_json(root_path, cache, query)
        path = query.empty? ? root_path : "#{root_path}#{query}"
        response =  Rails.cache.fetch(path, expires_in: cache[:expires_in], force: cache[:force]) do
            api.get(path)
        end
        [JSON.parse(response.body), response.status]
    end
    # end
end