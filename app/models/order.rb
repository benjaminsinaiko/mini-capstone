class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def as_json 
    {
      id: id,
      product_id: product_id,
      subtotal: subtotal,
      tax: tax,
      total: total
    }
  end
end
