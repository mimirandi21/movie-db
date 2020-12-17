class ImdbService
    require 'uri'
    require 'net/http'
    require 'openssl'
    
    def get_movie_by_name(input_name)

        base_url = ("https://imdb8.p.rapidapi.com/title/auto-complete?q=")
        search_params = "#{input_name.gsub(" ", "%20")}"
        url = URI(base_url + search_params)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV["IMDB_API_KEY"]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

        response = http.request(request)
        byebug
        # if response.body == '- Service Unavailable'
        json_hash= JSON.parse(response.body)
        return json_hash
                
    end

    def get_info_by_search_id(input_id)
        
        base_url = ("https://imdb8.p.rapidapi.com/title/get-overview-details?tconst=")
        search_params = "#{input_id}"
        url = URI(base_url + search_params + "&currentCountry=US")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV["IMDB_API_KEY"]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

        response = http.request(request)
        json_hash= JSON.parse(response.body)
        return json_hash
    end

    def get_crew_by_search_id(input_id)
        
        base_url = ("https://imdb8.p.rapidapi.com/title/get-top-crew?tconst=")
        search_params = "#{input_id}"
        url = URI(base_url + search_params)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV["IMDB_API_KEY"]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

        response = http.request(request)
        json_hash= JSON.parse(response.body)
        return json_hash
    end

    def get_cast_by_search_id(input_id)
        
        base_url = ("https://imdb8.p.rapidapi.com/title/get-top-cast?tconst=")
        search_params = "#{input_id}"
        url = URI(base_url + search_params)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV["IMDB_API_KEY"]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

        response = http.request(request)
        json_hash= JSON.parse(response.body)
        return json_hash
    end

    def get_person_by_imdb(imdb_link)
        
        base_url = ("https://imdb8.p.rapidapi.com/actors/get-bio?nconst=")
        search_params = "#{imdb_link.gsub("/name/", "")}"
        url = URI(base_url + search_params)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV["IMDB_API_KEY"]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

        response = http.request(request)
        json_hash= JSON.parse(response.body)
        return json_hash
    end
end