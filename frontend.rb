require 'unirest'

system 'clear'

puts "[1] print one contact from the list of contacts:"
puts "[2] print a list of the contacts:"
puts "[3] create a new contact to the list of contacts:"
puts "[4] update a contact in the list of the contacts:"
puts "[5] dlete a contact from the list of the contacts:"

input = gets.chomp

if input == "1"
  puts "Enter the ID of the contacts:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")  
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "2"
  response = Unirest.get("http://localhost:3000/contacts")
  all_contacts = response.body
  puts JSON.pretty_generate(all_contacts  )
elsif input == "3"
  params = {}
  puts "Enter a first name:"
  params["first_name"] = gets.chomp
  puts "Enter a last_name:"
  params["last_name"] = gets.chomp
  puts "Enter an email adress:"
  params["email"] = gets.chomp
  puts "Enter a phone_number:"
  params["phone_number"] = gets.chomp
  response = Unirest.post("http://localhost:3000/contacts", parameters: params)
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "4"
  params = {}
  puts "Enter the ID of the contacts to update:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  puts "Enter a first name to update a contact (#{contact['first_name']}):"
  params["first_name"] = gets.chomp
  puts "Enter a last_name to update a contact (#{contact['last_name']}):"
  params["last_name"] = gets.chomp
  puts "Enter an email adress to update a contact (#{contact['email']}):"
  params["email"] = gets.chomp
  puts "Enter a phone_number to update a contact (#{contact['phone_number']}):"
  params["phone_number"] = gets.chomp
  params.delete_if { |key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/contacts/#{input_id}", parameters: params)
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "5"
  puts "Enter the ID of the contacts to delete:"
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
  puts JSON.pretty_generate(response.body)
else
end

    







    