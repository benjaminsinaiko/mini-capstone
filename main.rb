require "unirest"
system "clear"

while true


  puts "Choose a pepper"
  puts "[1] Carolina Reaper"
  puts "[2] Habanero"
  puts "[3] Cayenne"
  puts "[4] Jalapeño"
  puts "[5] All peppers"
  puts "q to quit"
  puts

  input = gets.chomp

  if input == "1"
    response = Unirest.get("http://localhost:3000/carolinareaper")
    pepper = response.body
    puts pepper
  elsif input == "2"
    response = Unirest.get("http://localhost:3000/habanero")
    pepper = response.body
    puts pepper
  elsif input == "3"
    response = Unirest.get("http://localhost:3000/cayenne")
    pepper = response.body
    puts pepper
  elsif input == "4"
    response = Unirest.get("http://localhost:3000/jalapeno")
    pepper = response.body
    puts pepper
  elsif input == "5"
    response = Unirest.get("http://localhost:3000/peppers")
    pepper = response.body
    puts pepper
  elsif input == "q"
    break
  else
    puts "Choose again"
  end
  puts
end
