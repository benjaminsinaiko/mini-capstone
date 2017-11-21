require "unirest"
require "pp"

system "clear"
puts "Welcome to the Pepper App!"
puts "[1] See all peppers"
puts "[2] Create a pepper"
puts "[3] See one pepper"
puts "[4] Update a pepper"
puts "[5] Delete a pepper"

input = gets.chomp

if input == "1"
  response = Unirest.get("http://localhost:3000/v1/peppers")
  peppers = response.body
  pp peppers
elsif input == "2"
  params = {}
  print "Enter a pepper name: "
  params["name"] = gets.chomp
  print "Enter a price: "
  params["price"] = gets.chomp
  print "Enter an image url: "
  params["image"] = gets.chomp
  print "Enter a description: "
  params["description"] = gets.chomp
  print "Enter a species: "
  params["species"] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/peppers", parameters: params)
  pepper = response.body
  pp pepper
elsif input == "3"
  print "Pick a pepper by id: "
  pepper_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/peppers/#{pepper_id}")
  pepper = response.body
  pp pepper
elsif input == "4"
  print "Which pepper id would you like to update? "
  pepper_id = gets.chomp

  response = Unirest.get("http://localhost:3000/v1/peppers/#{pepper_id}")
  pepper = response.body
  
  params = {}
  print "Enter the updated pepper name (#{pepper["name"]}): "
  params["name"] = gets.chomp
  print "Enter the updated price (#{pepper["price"]}): "
  params["price"] = gets.chomp
  print "Enter the updated image url(#{pepper["image"]}): "
  params["image"] = gets.chomp
  print "Enter the updated description(#{pepper["description"]}): "
  params["description"] = gets.chomp
  print "Enter the updated species(#{pepper["species"]}): "
  params["species"] = gets.chomp

  params.delete_if {|key,value| value.empty?}

  response = Unirest.patch("http://localhost:3000/v1/peppers/#{pepper_id}", parameters: params)
  pepper = response.body
  pp pepper
elsif input == "5"
  print "Which recipe id do you want to destroy? "
  pepper_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/peppers/#{pepper_id}")
  pp response.body
end
