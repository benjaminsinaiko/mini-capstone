class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0 }
  validates :description, length: { maximum: 500 }

  def supplier
    Supplier.find_by(id: self.supplier_id)
  end

  def image
    Image.where(product_id: self.id)
  end

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
      image: image,
      description: description,
      is_discounted: is_discounted,
      tax: "$#{tax}",
      total: "$#{total}",
      image: image,
      supplier: supplier.as_json
    }
  end
end
