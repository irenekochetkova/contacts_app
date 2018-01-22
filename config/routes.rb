Rails.application.routes.draw do
 get "/contact" => "contacts#first_contact_method"
 get "/contacts" => "contacts#all_contacts_method"
end
