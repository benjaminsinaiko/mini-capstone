require "unirest"
require "pp"

class Frontend
  def initialize
    @jwt = ""
  end

  def run
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
      puts "[6] Show Orders"
      puts "[7] Show Carted Products"
      puts "[8] Purchase Items In Cart"
      puts "[9] Remove Item From Cart"
      puts
      puts "[signup] Signup (create a user)"
      puts "[login] Login (create create json token)"
      puts "[logout] Logout (create delete token)"
      puts
      puts "[q] Quit"

      input = gets.chomp

      def show_peppers
        response = Unirest.get("http://localhost:3000/v1/peppers")
        peppers = response.body
        pp peppers
      end

      def search_pepper
        print "Enter search terms: "
        search_terms = gets.chomp
        puts "Here are the matching peppers"
        response = Unirest.get("http://localhost:3000/v1/peppers?search=#{search_terms}")
        peppers = response.body
        pp peppers
      end

      def sort_peppers_by_price
        response = Unirest.get("http://localhost:3000/v1/peppers?price=")
        peppers = response.body
        pp peppers
      end

      def create_pepper
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
      end

      def show_pepper_by_id
        print "Pick a pepper by id: "
        pepper_id = gets.chomp
        response = Unirest.get("http://localhost:3000/v1/peppers/#{pepper_id}")
        pepper = response.body
        pp pepper
        puts
        print "Order (Y/N)? "
        input = gets.chomp
        if input == "Y"
          params = {}
          params[:pepper_id] = pepper_id
          print "How many? "
          params[:quantity] = gets.chomp
          response = Unirest.post("http://localhost:3000/v1/carted_products", parameters: params)
          order = response.body
          pp order
        end
      end

      def update_pepper_by_id
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
      end

      def delete_pepper_by_id
        print "Which recipe id do you want to destroy? "
        pepper_id = gets.chomp
        response = Unirest.delete("http://localhost:3000/v1/peppers/#{pepper_id}")
        pp response.body
      end

      def show_orders
        response = Unirest.get("http://localhost:3000/v1/orders")
        orders = response.body
        pp orders
      end

      def show_carted_products
        response = Unirest.get("http://localhost:3000/v1/carted_products")
        carted_products = response.body
        pp carted_products
      end

      def create_order
        response = Unirest.post("http://localhost:3000/v1/orders")
        purchase_order = response.body
        pp purchase_order
      end

      def remove_carted_product
        print "Which item would you like to remove? "
        carted_product_id = gets.chomp
        response = Unirest.patch("http://localhost:3000/v1/carted_products/#{carted_product_id}", parameters: {id: carted_product_id})
        pp response.body
      end

      def signup
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
      end

      def login
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
      end

      def logout
        jwt = ""
        Unirest.clear_default_headers()
      end

      if input == "1"
        show_peppers
      elsif input == "1.1"
        search_pepper
      elsif input == "1.2"
        sort_peppers_by_price
      elsif input == "2"
        create_pepper
      elsif input == "3"
        show_pepper_by_id
      elsif input == "4"
        update_pepper_by_id
      elsif input == "5"
        delete_pepper_by_id
      elsif input == "6"
        show_orders
      elsif input == "7"
        show_carted_products
      elsif input == "8"
        create_order
      elsif input == "9"
        remove_carted_product
      elsif input == "signup"
        signup
      elsif input == "login"
        login
      elsif input == "loutout"
        logout
      elsif input == "q"
        puts "Goodbye!"
        break
      end
      puts
      puts "Press enter to continue"
      gets.chomp
    end    
  end
end
frontend = Frontend.new
frontend.run