require 'unirest'

system 'clear'

puts "[1] print first contact:"
puts "[2] print all contacts:"

input = gets.chomp

if input == "1"
  response = Unirest.get("http://localhost:3000/contact")
  contact_first = response.body
  puts JSON.pretty_generate(contact_first)
elsif input == "2"
  response = Unirest.get("http://localhost:3000/contacts")
  all_contact = response.body
  puts JSON.pretty_generate(all_contact)
end
    