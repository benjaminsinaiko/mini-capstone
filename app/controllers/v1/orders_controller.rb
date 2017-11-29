class V1::OrdersController < ApplicationController
  def index
    orders = current_user.orders
    render json: orders.as_json
  end

  def create
    pepper = Product.find_by(id: params[:pepper_id])
    quantity = params[:quantity]
    # subtotal = pepper.price * quantity

    order = Order.new(
      product_id: params[:pepper_id],
      quantity: quantity,
      # subtotal: subtotal,
      # tax: subtotal * product_id.tax,
      total: pepper.total,
      user_id: current_user.id
    )
    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end
end