require 'faraday'
require 'json'

class Connection

    def self.api
        BASE = ("https://imdb8.p.rapidapi.com/")
        Faraday.new(url: BASE) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def self.movie_api
        base_url = ("https://imdb8.p.rapidapi.com/title/auto-complete?q=")
        Faraday.new(url: base_url) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def self.info_api
        base_url = ("https://imdb8.p.rapidapi.com/title/get-overview-details?tconst=")
        Faraday.new(url: base_url) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def self.cast_api
        base_url = ("https://imdb8.p.rapidapi.com/title/get-top-cast?tconst=")
        Faraday.new(url: base_url) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def self.crew_api
        base_url = ("https://imdb8.p.rapidapi.com/title/get-top-crew?tconst=")
        Faraday.new(url: base_url) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end

    def self.person_api
        base_url = ("https://imdb8.p.rapidapi.com/actors/get-bio?nconst=")
        Faraday.new(url: base_url) do |faraday|
            faraday.response :logger
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = 'application/json'
            faraday.headers['x-rapidapi-key'] = ENV['IMDB_API_KEY']
        end
    end
end