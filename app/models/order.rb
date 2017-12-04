class Order < ApplicationRecord
  belongs_to :user
  # belongs_to :product
  has_many :carted_product

  def as_json 
    {
      id: id,
      subtotal: subtotal,
      tax: tax,
      total: total
    }
  end
end
