require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://imdb8.p.rapidapi.com/title/get-top-crew?tconst=tt0944947")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '00991b4ef8mshc417b4984675468p1d2735jsn3840e05b8194'
request["x-rapidapi-host"] = 'imdb8.p.rapidapi.com'

response = http.request(request)
puts response.read_body