class ImdbService

    def get_movie_by_name(input_name)
        
        require 'uri'
        require 'net/http'
        require 'openssl'

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
        json_hash= JSON.parse(response.body)
        return json_hash
                
    end

    def get 
    end
end