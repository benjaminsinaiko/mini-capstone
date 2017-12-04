class V1::CartedProductsController < ApplicationController
  def index
    carted_products = current_user.carted_products
    render json: carted_products.as_json
  end

  def create
    pepper = Product.find_by(id: params[:pepper_id])
    quantity = params[:quantity].to_d

    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:pepper_id],
      quantity: quantity,
      status: "carted"
    )
    if carted_product.save
      render json: carted_product.as_json, status: :create
    else
      render json: {errors: carted_product.errors.full_messaegs}, statuts: :bad_request
    end 
  end
end
