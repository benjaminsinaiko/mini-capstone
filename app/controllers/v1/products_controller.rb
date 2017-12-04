class V1::ProductsController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]

  def index
    peppers = Product.all.order(:id => :asc)
    if params[:search]
      peppers = peppers.where("name ILIKE ?", "%#{params[:search]}%")
    end
    if params[:price]
      peppers = Product.all.order(:price => :asc)
    end

    category_id = params[:input_category_id]
    if category_id
      category = Category.find_by(id: category_id)
      products = category.products
    end

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
    if pepper.save
      render json: pepper.as_json
    else
      render json: {errors: pepper.errors.full_messages}, status: :bad_request
    end
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
    if pepper.save
      render json: pepper.as_json
    else
      render json: {errors: pepper.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    pepper_id = params["id"]
    pepper = Product.find_by(id: pepper_id)
    pepper.destroy
    render json: {message: "Pepper successfully deleted"}
  end
end
 