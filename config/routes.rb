Rails.application.routes.draw do
  namespace :v1 do
    get "/peppers" => "products#index"
    post "/peppers" => "products#create"
    get "/peppers/:id" => "products#show"
    patch "/peppers/:id" => "products#update"
    delete "/peppers/:id" => "products#destroy"
  end
end
