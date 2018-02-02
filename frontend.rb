require 'unirest'

while true

system 'clear'

puts "[1] print one contact from the list of contacts:"

puts "[1.1] search First name:"
puts "[2] print a list of the contacts:"
puts "[3] create a new contact to the list of contacts:"
puts "[4] update a contact in the list of the contacts:"
puts "[5] delete a contact from the list of the contacts:"

puts "[6] Signup (create a user)"
puts "[7] Login (create a JSON web token):"
puts "[8] Logout(erase a JSON web token):"

puts "[9] See one contact and associated groups:"

puts "[q] To quit"

input = gets.chomp

if input == "1"
  puts "Enter the ID of the contacts:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")  
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "1.1"
  puts " Enter search term of the contact:"
  search = gets.chomp
  puts "Here are all the matching contacts:"
  response = Unirest.get("http://localhost:3000/contacts?search=#{search}")
  puts JSON.pretty_generate(response.body)

elsif input == "2"
  response = Unirest.get("http://localhost:3000/contacts")
  all_contacts = response.body
  puts JSON.pretty_generate(all_contacts)
elsif input == "3"
  params = {}
  puts "Enter a first name:"
  params["first_name"] = gets.chomp

  puts "Enter a middle name:"
  params["middle_name"] = gets.chomp
  puts "Enter a last_name:"
  params["last_name"] = gets.chomp
  
  puts "Enter an email adress:"
  params["email"] = gets.chomp
  puts "Enter a phone number:"
  params["phone_number"] = gets.chomp
  puts "Enter a bio:" 
  params["bio"] = gets.chomp
  response = Unirest.post("http://localhost:3000/contacts", parameters: params)
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "4"
  params = {}
  puts "Enter the ID of the contacts to update:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  puts "Enter a first name to update a contact (#{contact['full_name']}):"
  params["first_name"] = gets.chomp
  puts "Enter a last_name to update a contact (#{contact['full_name']}):"
  params["last_name"] = gets.chomp
  puts "Enter a middle name to update a contact (#{contact['full_name']}):"
  params["middle_name"] = gets.chomp
  puts "Enter an email adress to update a contact (#{contact['email']}):"
  params["email"] = gets.chomp
  puts "Enter a phone_number to update a contact (#{contact['phone_number']}):"
  params["phone_number"] = gets.chomp
  puts "Enter a bio to update a contact (#{contact['bio']}):"
  params["bio"] = gets.chomp

  params.delete_if { |key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/contacts/#{input_id}", parameters: params)
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input == "5"
  puts "Enter the ID of the contacts to delete:"
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
  puts JSON.pretty_generate(response.body)
elsif input == "6"
  puts "Signup!"
  params = {}
  puts "Name: "
  params[:name] = gets.chomp
  puts "Email:"
  params[:email] = gets.chomp
  puts "Password:"
  params[:password] = gets.chomp
  puts "Confirm password:"
  params[:password_confirmation] = gets.chomp
  response = Unirest.post("http://localhost:3000/users", parameters: params)
  puts JSON.pretty_generate(response.body)
elsif input == "7"
  puts "Email:"
  input_email = gets.chomp
  puts "Password:"
  input_password = gets.chomp
  response = Unirest.post("http://localhost:3000/user_token", 
    parameters: {
      auth: {
        email: input_email, 
        password: input_password
      }
    }
  )
  
  jwt = response.body["jwt"]
  puts jwt
  Unirest.default_header("Authorization",  "Bearer #{jwt}")

  elsif input == "8"
  jwt = ""
  Unirest.clear_default_headers()

  elsif input == "9"
  puts "Enter the ID of the group to see all contacts of this group:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/groups/#{input_id}")
  puts JSON.pretty_generate(response.body)

  elsif input == "q"
  puts "Bye!"
  break
  end
  "Press any key to continue " 
  gets.chomp

end

    







    