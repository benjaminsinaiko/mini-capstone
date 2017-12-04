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
      render json: {errors: carted_product.errors.full_messages}, statuts: :bad_request
    end 
  end

  def update
    carted_product_id = params[:id]
    carted_product = CartedProduct.find_by(user_id: current_user.id, id: carted_product_id)
    if carted_product.status == "carted"
      carted_product.update(status: "removed")
      carted_product.save
      render json: {message: "Item removed from cart"}
    else
      render json: {errors: carted_product.errors.full_messages}, status: :bad_request
    end
  end
end
