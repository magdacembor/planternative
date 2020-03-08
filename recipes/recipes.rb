require "rest-client"
require "json"

File.open("recipes.json", "a+") do |file|
  json = RestClient.get("https://www.edamam.com/search?q=snack&health=vegan&from=0&to=100")
  file.write(json)
end
