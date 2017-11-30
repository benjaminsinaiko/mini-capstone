class V1::OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    orders = current_user.orders
    render json: orders.as_json
  end

  def create
    pepper = Product.find_by(id: params[:pepper_id])
    quantity = params[:quantity].to_d
    subtotal = pepper.price * quantity

    order = Order.new(
      product_id: params[:pepper_id],
      quantity: quantity,
      subtotal: subtotal,
      tax: subtotal * pepper.tax,
      total: pepper.total * quantity,
      user_id: current_user.id
    )
    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.as_json(full_messages: true)}, status: :bad_request
    end
  end
end
