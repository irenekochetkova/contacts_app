Rails.application.routes.draw do

 post 'user_token' => 'user_token#create'
 get "/contacts/:id" => "contacts#show"
 get "/contacts" => "contacts#index"
 post "/contacts" => "contacts#create"
 patch "/contacts/:id" => "contacts#update"
 delete "/contacts/:id" => "contacts#destroy"

 post "/users" => "users#create"
end
