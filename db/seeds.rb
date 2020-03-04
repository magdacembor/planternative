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

  { name: "This Isn't Bacon", price_range: "£££", low_cal: false, high_protein: true, gluten_free: true, description: "Ready-to-cook, (ridiculously) high in protein, fortified with vitamin B12 & iron 120g.", ingredients: "Water, Soy Protein Concentrate (22%), Soy Protein Isolate (7%), Flavouring, Pea Protein Isolate (4%), Vegetable Extracts (Radish, Carrot, Paprika), Potato Starch, Salt, Rapeseed Oil, Maltodextrin, Iron, Vitamin B12.", protein_per_100g: 24.5, fat_per_100g: 1.2, calories_per_100g: 152, carbs_per_100g: 10.6, user_id: 1, water_saved: 999, energy_saved: 999 },
  { name: "This Isn't Chicken", price_range: "£££", low_cal: false, high_protein: true, gluten_free: false, description: "Ready-to-cook, (ridiculously) high in protein, fortified with vitamin B12 & iron 190g.", ingredients: "Water, Soy Protein Concentrate (28%), Canola Oil, Soy and Garlic Seasoning [Soy and Garlic Seasoning contains: Sugar, Soy Sauce Powder (Soy, Wheat), Dark Brown Sugar, Dried Roasted Garlic, Garlic Powder, Maltodextrin, Barley Malt Extract, Spice (Ginger), Yeast Extract Powder, Natural Flavouring, Onion Powder, Thickener (Guar Gum), Dried Red Bell Pepper, Citric Acid, Cornflour (Maize Starch), Herb (Parsley)], Flavouring, Pea Protein Isolate (2%), Potato Starch, Pea Fibre (1%), Maltodextrin, Salt, Iron, Vitamin B12.", protein_per_100g: 21.8, fat_per_100g: 5.3, calories_per_100g: 161, carbs_per_100g: 5.5, user_id: 1, water_saved: 999, energy_saved: 999 }

]

path = Rails.root.join('product_images').to_s
i = 0
Dir.foreach(path) do |dir|
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

  { date: Date.today, user_id: 1, mark_as_done: true },
  { date: Date.today, user_id: 1, mark_as_done: true }

]

@shopping_lists.each_with_index do |shopping_list, i|
  shopping_list_created = ShoppingList.create!(shopping_list)
  puts "#{i + 1}. Shopping list #{shopping_list_created.id} created"
end

puts "\nCreating quantities..."

@quantities = [

  { quantity: 2, product_id: 1, shopping_list_id: 1 },
  { quantity: 3, product_id: 2, shopping_list_id: 1 },
  { quantity: 4, product_id: 1, shopping_list_id: 2 },
  { quantity: 1, product_id: 2, shopping_list_id: 2 }

]

@quantities.each_with_index do |quantity, i|
  quantity_created = Quantity.create!(quantity)
  puts "#{i + 1}. Quantity: #{quantity_created.quantity} of \"#{quantity_created.product.name}\" added to #{quantity_created.shopping_list.user.first_name}\'s shopping list no. #{quantity_created.shopping_list_id}"
end

puts "\nCreating meals..."

@meals = [

  { name: "Carbonara" },
  { name: "Chicken Curry" },
  { name: "Chicken Risotto" }

]

@meals.each_with_index do |meal, i|
  meal_created = Meal.create!(meal)
  puts "#{i + 1}. Meal #{meal_created.name} created"
end

puts "\nCreating substitutions..."

@substitutions = [

  { name: "Bacon", meal_id: 1, product_id: 1 },
  { name: "Chicken", meal_id: 2, product_id: 2 },
  { name: "Chicken", meal_id: 3, product_id: 2 }

]

@substitutions.each_with_index do |substitution, i|
  substitution_created = Substitution.create!(substitution)
  puts "#{i + 1}. Substitution \"#{substitution_created.name}\" for meal \"#{substitution_created.meal.name}\" created"
end

puts "\nDone!"
