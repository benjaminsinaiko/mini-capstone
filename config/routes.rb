Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  namespace :v1 do
    get "/carted_products" => "carted_products#index"
    post "carted_products" => "carted_products#create"
    patch "carted_products/:id" => "carted_products#update"
    post "/users" => "users#create"

    get "/peppers" => "products#index"
    post "/peppers" => "products#create"
    get "/peppers/:id" => "products#show"
    patch "/peppers/:id" => "products#update"
    delete "/peppers/:id" => "products#destroy"

    get "/orders" => "orders#index"
    post "/orders" => "orders#create"
  end
end
