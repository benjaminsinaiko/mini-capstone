class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0 }
  validates :description, length: { maximum: 500 }

  belongs_to :supplier
  # def supplier
  #   Supplier.find_by(id: self.supplier_id)
  # end
  has_many :orders
  has_many :images
  # def image
  #   Image.where(product_id: self.id)
  # end

  def tax
    tax = 0.09 * price
    return tax.round(2)
  end

  def total
    total_price = price + tax
    return total_price
  end

  def is_discounted
    price < 6
  end

  def as_json
    {
      id: id,
      name: name,
      price: price,
      description: description,
      is_discounted: is_discounted,
      tax: "$#{tax}",
      total: "$#{total}",
      images: images.as_json,
      supplier: supplier.as_json
    }
  end
end
