class V1::ProductsController < ApplicationController
  def index
    peppers = Product.all
    render json: peppers.as_json
  end

  def create
    pepper = Product.new(
      name: params["name"],
      price: params["price"],
      image: params["image"],
      description: params["description"],
      species: params["species"]
    )
    pepper.save
    render json: pepper.as_json
  end

  def show
    pepper_id = params["id"]
    pepper = Product.find_by(id: pepper_id)
    render json: pepper.as_json
  end

  def update
    pepper_id = params["id"]
    pepper = Product.find_by(id: pepper_id)
    pepper.name = params["name"] || pepper.name
    pepper.price = params["price"] || pepper.price
    pepper.image = params["image"] || pepper.image
    pepper.description = params["description"] || pepper.description
    pepper.species = params["species"] || pepper.species
    pepper.save
    render json: pepper.as_json
  end

  def destroy
    pepper_id = params["id"]
    pepper = Product.find_by(id: pepper_id)
    pepper.destroy
    render json: {message: "Pepper successfully deleted"}
  end
end
 