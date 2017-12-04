class V1::OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    orders = current_user.orders
    render json: orders.as_json
  end

  def create
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    subtotal = 0
    carted_products.each do |pepper|
      product = Product.find_by(id: pepper[:product_id])
      subtotal += product.price * pepper.quantity
    end
    tax = subtotal * 0.09
    order = Order.new(
      subtotal: subtotal,
      tax: tax,
      total: subtotal + tax,
      user_id: current_user.id
    )
    if order.save
      carted_products.update_all(status: "purchased", order_id: order[:id])
      render json: order.as_json, status: :create
    else
      render json: {errors: order.errors.as_json(full_messages: true)}, status: :bad_request
    end
  end
end
