# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Creating users..."


@users = [

  { email: "john@gmail.com", first_name: "John", last_name: "Smith", password: "User1234", nickname: "john" },
  { email: "sarah@gmail.com", first_name: "Sarah", last_name: "Williams", password: "User1234", nickname: "sarah" },
  { email: "alex@gmail.com", first_name: "Alex", last_name: "Baker", password: "User1234", nickname: "alex" },
  { email: "phoebe@gmail.com", first_name: "Phoebe", last_name: "Yu", password: "User1234", nickname: "phoebe" }

]

@users.each_with_index do |user, i|
  User.create!(user)
  puts "#{i + 1}. User #{user[:email]} created"
end

puts "\nCreating products..."

@products = [

  { name: "This Isn't Bacon", price_range: "££", low_cal: false, high_protein: true, gluten_free: true, description: "Ready-to-cook, (ridiculously) high in protein, fortified with vitamin B12 & iron 120g.", ingredients: "Water, Soy Protein Concentrate (22%), Soy Protein Isolate (7%), Flavouring, Pea Protein Isolate (4%), Vegetable Extracts (Radish, Carrot, Paprika), Potato Starch, Salt, Rapeseed Oil, Maltodextrin, Iron, Vitamin B12.", protein_per_100g: 24.5, fat_per_100g: 1.2, calories_per_100g: 152, carbs_per_100g: 10.6, user_id: 1, water_saved: 1, energy_saved: 1 },
  { name: "This Isn't Chicken", price_range: "££", low_cal: false, high_protein: true, gluten_free: false, description: "Ready-to-cook, (ridiculously) high in protein, fortified with vitamin B12 & iron 140g.", ingredients: "Water, Soy Protein Concentrate (28%), Canola Oil, Rotisserie Seasoning [Rotisserie Seasoning contains: Dark Brown Sugar, Sugar, Yeast Extract Powder, Maltodextrin, Garlic Powder, Onion Powder, Natural Flavouring, Cornflour (Maize Starch), Burnt Sugar, Spice (Black Pepper), Citric Acid, Smoked Salt], Flavouring, Pea Protein Isolate (2%), Potato Starch, Pea Fibre (1%), Maltodextrin, Salt, Iron, Vitamin B12.", protein_per_100g: 21.8, fat_per_100g: 5.5, calories_per_100g: 163, carbs_per_100g: 5.5, user_id: 1, water_saved: 9, energy_saved: 1 },
  { name: "Seamore I Sea Seaweed Bacon", price_range: "£££", low_cal: false, high_protein: true, gluten_free: true, description: "I sea bacon is 100% organic seaweed that turns into (green) bacon when fried. Handpicked and sustainably harvested in France. Put it on anything that deserves a crunchy, salty, smoky kick or use the soaked soft leaves as a flavor boost in salads, pastas or anything else. Great for your taste buds, health and the planet. Eat yourself happy.", ingredients: "Dried organic seaweed (Palmaria Palmata)", protein_per_100g: 14.3, fat_per_100g: 0.1, calories_per_100g: 229, carbs_per_100g: 21.2, user_id: 1, water_saved: 1, energy_saved: 1 },
  { name: "Tofurky Smoky Maple Bacon Tempeh", price_range: "£££", low_cal: false, high_protein: true, gluten_free: false, description: "Meet tofu's weird-but-cool cousin, tempeh. It gets along great with a tasty marinade, like this smoky maple bacon style sauce. We call it Treehouse Tempeh in honour of our fearless founder, Seth, who lived in a treehouse during his early tempeh-making days. Look it up!", ingredients: "Water, Organic Soybeans (38%), Soy Sauce (Water, Soybeans, Wheat, Salt), Molasses, Maple Syrup, Natural Flavours, Autolyzed Yeast Extract, Sea Salt, Natural Smoke Flavour, Organic Apple Cider Vinegar, Starter Culture: (Rhizopus Oligosporus)", protein_per_100g: 15.0, fat_per_100g: 5.5, calories_per_100g: 174, carbs_per_100g: 14.0, user_id: 1, water_saved: 1, energy_saved: 1 },
  { name: "Vegideli Cheatin' Vegan Bacon", price_range: "££", low_cal: false, high_protein: true, gluten_free: false, description: "The Red Wood Co Streaky Style Meat Free Cheatin' Rashers. A delicious blend of wheat gluten, soya & vegetable oil.", ingredients: "Water, Wheat Gluten, Soya Protein, Non-Hydrogenated Vegetable Fat (Sustainable Palm), Textured Wheat Protein, Potato Starch, Salt, Dried Yeast, Sugar, Natural Flavourings, Thickeners: Carrageenan, Preservative: Potassium Sorbate, Onion Powder, Colour: Iron Oxide", protein_per_100g: 25.8, fat_per_100g: 7.8, calories_per_100g: 196, carbs_per_100g: 6.1, user_id: 1, water_saved: 1, energy_saved: 1 }

]

path = Rails.root.join('product_images').to_s
i = 0
dir_array = []
Dir.foreach(path) do |dir|
  next unless dir.match?(/(\d)/)
  num = dir.match(/(\d)/)[1].to_i
  dir_array << dir
end
dir_array.sort!
dir_array.each do |dir|
  if dir.include?('images') && @products[i].present?
    product = Product.create! @products[i]
    puts "#{i + 1}. Product \"#{product.name}\" created"
    puts "Directory: #{dir}"
    images_to_attach = []
    Dir.foreach(File.join(path, dir)) do |file|
      if file.include?('.jpg')
        puts "File: #{file}"
        uploaded_file = Cloudinary::Uploader.upload(File.join(path, dir, file))
        images_to_attach << { io: URI.open(uploaded_file['secure_url']), filename: file, content_type: 'image/jpg' }
        puts 'Uploaded!'
      elsif file.include?('.png')
        puts "File: #{file}"
        uploaded_file = Cloudinary::Uploader.upload(File.join(path, dir, file))
        images_to_attach << { io: URI.open(uploaded_file['secure_url']), filename: file, content_type: 'image/png' }
        puts 'Uploaded!'
      end
    end
    product.update!(images: images_to_attach)
    puts "Images attached!"
    i += 1
  end
end

puts "\nCreating shopping lists..."

@shopping_lists = [

  { date: Date.today - 1, user_id: 1, mark_as_done: true },
  { date: Date.today - 3, user_id: 1, mark_as_done: true },
  { date: Date.today - 7, user_id: 1, mark_as_done: true },
  { date: Date.today - 12, user_id: 1, mark_as_done: true },
  { date: Date.today - 1, user_id: 2, mark_as_done: true },
  { date: Date.today - 5, user_id: 2, mark_as_done: true },
  { date: Date.today - 2, user_id: 3, mark_as_done: true },
  { date: Date.today - 10, user_id: 3, mark_as_done: true }

]

@shopping_lists.each_with_index do |shopping_list, i|
  shopping_list_created = ShoppingList.create!(shopping_list)
  puts "#{i + 1}. Shopping list #{shopping_list_created.id} for #{shopping_list_created.user.first_name}"
end

puts "\nCreating quantities..."

@quantities = [

  { quantity: 2, product_id: 1, shopping_list_id: 1 },
  { quantity: 3, product_id: 2, shopping_list_id: 1 },
  { quantity: 4, product_id: 1, shopping_list_id: 2 },
  { quantity: 1, product_id: 2, shopping_list_id: 2 },
  { quantity: 1, product_id: 1, shopping_list_id: 3 },
  { quantity: 1, product_id: 2, shopping_list_id: 3 },
  { quantity: 2, product_id: 1, shopping_list_id: 4 },
  { quantity: 2, product_id: 2, shopping_list_id: 4 },
  { quantity: 3, product_id: 1, shopping_list_id: 5 },
  { quantity: 3, product_id: 2, shopping_list_id: 5 },
  { quantity: 4, product_id: 1, shopping_list_id: 6 },
  { quantity: 4, product_id: 2, shopping_list_id: 6 },
  { quantity: 1, product_id: 1, shopping_list_id: 7 },
  { quantity: 1, product_id: 2, shopping_list_id: 7 },
  { quantity: 2, product_id: 1, shopping_list_id: 8 },
  { quantity: 1, product_id: 2, shopping_list_id: 8 }

]

@quantities.each_with_index do |quantity, i|
  quantity_created = Quantity.create!(quantity)
  puts "#{i + 1}. Quantity: #{quantity_created.quantity} of \"#{quantity_created.product.name}\" added to #{quantity_created.shopping_list.user.first_name}\'s shopping list no. #{quantity_created.shopping_list_id}"
end

puts "\nCreating meals..."

@meals = [

  { name: "Carbonara" },
  { name: "Chicken Curry" },
  { name: "Chicken Risotto" },
  { name: "Bolognese" }

]

@meals.each_with_index do |meal, i|
  meal_created = Meal.create!(meal)
  puts "#{i + 1}. Meal #{meal_created.name} created"
end

puts "\nCreating substitutions..."

@substitutions = [

  { name: "Bacon", meal_id: 1, product_id: 1 },
  { name: "Bacon", meal_id: 1, product_id: 3 },
  { name: "Bacon", meal_id: 1, product_id: 4 },
  { name: "Bacon", meal_id: 1, product_id: 5 },
  { name: "Chicken", meal_id: 2, product_id: 2 },
  { name: "Chicken", meal_id: 3, product_id: 2 }

]

@substitutions.each_with_index do |substitution, i|
  substitution_created = Substitution.create!(substitution)
  puts "#{i + 1}. Substitution \"#{substitution_created.name}\" for meal \"#{substitution_created.meal.name}\" created"
end

puts "\nCreating reviews..."

@reviews = [

  { product_id: 1, rating: 5, content: "Delicious!", user_id: 1 },
  { product_id: 1, rating: 4, content: "A very good product, albeit not quite as crispy as the real thing.", user_id: 2 },
  { product_id: 1, rating: 5, content: "That was a game changer for me!", user_id: 3 },
  { product_id: 2, rating: 5, content: "I wouldn't have guessed this wasn't real chicken!", user_id: 1 },
  { product_id: 2, rating: 5, content: "Fantastic, so full of flavour!", user_id: 2 },
  { product_id: 2, rating: 4, content: "Tasty stuff", user_id: 3 },
  { product_id: 3, rating: 4, content: "Very good!", user_id: 1 },
  { product_id: 3, rating: 5, content: "Fantastic!!!", user_id: 2 },
  { product_id: 3, rating: 5, content: "My favourite from their range", user_id: 3 },
  { product_id: 3, rating: 4, content: "Really tasty", user_id: 4 }

]

@reviews.each_with_index do |review, i|
  review_created = Review.create!(review)
  puts "#{i + 1}. Review \"#{review_created.content}\" with rating #{review_created.rating
} for product \"#{review_created.product.name}\" by user #{review_created.user.nickname} created"
end

puts "\nCreating stores ..."

@stores = [

  { name: "Sainsbury's", address: "112/118 Kingsland Road, London" },
  { name: "Marks & Spencer", address: "70 Finsbury Pavement, London" },
  { name: "Tesco Express", address: "79-85 Hackney Road, London" },
  { name: "Iceland Foods", address: "209/233 Hoxton St, London" },
  { name: "Tesco Express", address: "25-29 Islington Green, London" },
  { name: "Iceland Foods", address: "150 Mare St, London" },
  { name: "Lidl", address: "27 Well St, London" },
  { name: "Iceland Foods", address: "337 Mare Street, London, E8 1HY" },
  { name: "Tesco Express", address: "179 Shoreditch High St, London" },
  { name: "Iceland Foods", address: "64 Chapel Market, London N1 9ER" },
  { name: "Lidl", address: "306 Burdett Rd, London" }

]

@stores.each_with_index do |store, i|
  store_created = Store.create!(store)
  puts "#{i + 1}. Store #{store_created.name} created"
end

puts "\nCreating availabilities..."

@availabilities = [

  { product_id: 1, store_id: 1 },
  { product_id: 1, store_id: 2 },
  { product_id: 1, store_id: 3 },
  { product_id: 1, store_id: 4 },
  { product_id: 1, store_id: 5 },
  { product_id: 2, store_id: 1 },
  { product_id: 2, store_id: 2 },
  { product_id: 2, store_id: 3 },
  { product_id: 2, store_id: 4 },
  { product_id: 2, store_id: 5 },
  { product_id: 2, store_id: 6 },
  { product_id: 3, store_id: 1 },
  { product_id: 3, store_id: 3 },
  { product_id: 3, store_id: 4 },
  { product_id: 3, store_id: 5 },
  { product_id: 3, store_id: 6 },
  { product_id: 4, store_id: 1 },
  { product_id: 4, store_id: 3 },
  { product_id: 4, store_id: 4 },
  { product_id: 4, store_id: 5 },
  { product_id: 4, store_id: 6 },
  { product_id: 5, store_id: 3 },
  { product_id: 5, store_id: 4 },
  { product_id: 5, store_id: 5 },
  { product_id: 5, store_id: 7 },
  { product_id: 5, store_id: 8 }

]

@availabilities.each_with_index do |availability, i|
  availability_created = Availability.create!(availability)
  puts "#{i + 1}. Availability: #{availability_created.product.name } at #{availability_created.store.name}"
end

puts "\nDone!"
