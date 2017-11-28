Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    post "/users" => "users#create"

    get "/peppers" => "products#index"
    post "/peppers" => "products#create"
    get "/peppers/:id" => "products#show"
    patch "/peppers/:id" => "products#update"
    delete "/peppers/:id" => "products#destroy"
  end
end
