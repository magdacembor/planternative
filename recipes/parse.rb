require 'json'

queries = [ "bolognese", "carbonara", "burger", "curry", "spaghetti", "risotto", "fish and chips" ]

File.open("output.json", "a+") do |file|
  queries.each do |query|
    json = File.read("#{query}.json")
    data = JSON.parse(json)
    data["hits"].each_with_index do |recipe, i|
      if i <= 5 && recipe["recipe"]["label"].match?(/.*#{query}.*/i)
        file.write("{ name: \"#{recipe["recipe"]["label"]}\", url: \"#{recipe["recipe"]["url"]}\", image_url: \"#{recipe["recipe"]["image"]}\", product_id: 1 },\n")
      end
    end
  end
end
