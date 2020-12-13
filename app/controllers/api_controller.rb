class ApiController < ApplicationController
    
    def self.test
        require 'net/http'
        require 'openssl'
    
        url = URI("https://imdb8.p.rapidapi.com/title/auto-complete?q=game%20of%20thr")
    
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"]  = ENV[IMDB_API_KEY]
        request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'
    
        response = http.request(request)
        puts response.read_body
        
    end
end