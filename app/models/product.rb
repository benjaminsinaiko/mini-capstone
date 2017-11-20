class Product < ApplicationRecord
  def price_num
    price_num = price.sub("$", "").to_f
    return price_num
  end

  def tax
    tax = 0.09 * price_num
    return tax.round(2)
  end

  def total
    total_price = price_num + tax
    return total_price
  end

  def discounted
    is_discounted = false
    if price_num < 6
      is_discounted = true
    end
    return is_discounted
  end

  def as_json
    {
      id: id,
      price: price,
      image: image,
      description: description,
      discounted: discounted,
      tax: "$#{tax}",
      total: "$#{total}"
    }
  end
end
