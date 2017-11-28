require "unirest"
require "pp"

while true
  system "clear"
  puts "Welcome to the Pepper App!"
  puts "[1] See all peppers"
  puts "  [1.1] Search for a pepper"
  puts "  [1.2] Sort by price"
  puts "[2] Create a pepper"
  puts "[3] See one pepper"
  puts "[4] Update a pepper"
  puts "[5] Delete a pepper"
  puts
  puts "[signup] Signup (create a user)"
  puts "[login] Login (create create json token)"
  puts "[logout] Logout (create delete token)"
  puts
  puts "[q] Quit"

  input = gets.chomp

  if input == "1"
    response = Unirest.get("http://localhost:3000/v1/peppers")
    peppers = response.body
    pp peppers
  elsif input == "1.1"
    print "Enter search terms: "
    search_terms = gets.chomp
    puts "Here are the matching peppers"
    response = Unirest.get("http://localhost:3000/v1/peppers?search=#{search_terms}")
    peppers = response.body
    pp peppers
  elsif input == "1.2"
    response = Unirest.get("http://localhost:3000/v1/peppers?price=")
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
    if pepper["errors"]
      puts
      puts "No good!"
      p pepper["errors"]
    else
      pp pepper
    end
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

    params.delete_if {|value| value.empty?}

    response = Unirest.patch("http://localhost:3000/v1/peppers/#{pepper_id}", parameters: params)
    pepper = response.body
    pp pepper
  elsif input == "5"
    print "Which recipe id do you want to destroy? "
    pepper_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/peppers/#{pepper_id}")
    pp response.body
  elsif input == "signup"
    params = {}
    print "Name: "
    params[:name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    print "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
    pp response.body
  elsif input == "login"
    puts "Login to the app"
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input == "loutout"
    jwt = ""
    Unirest.clear_default_headers()
  elsif input == "q"
    puts "Goodbye!"
    break  
  end
  puts
  puts "Press enter to continue"
  gets.chomp
end

