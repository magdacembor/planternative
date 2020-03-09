require "rest-client"
require "json"

File.open("fish and chips.json", "a+") do |file|
  json = RestClient.get("https://www.edamam.com/search?q=fish and chips&health=vegan&from=0&to=100")
  file.write(json)
end
