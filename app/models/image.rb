class Image < ApplicationRecord
  belongs_to :product

  def as_json
    {
      images: image_url,
      product_id: product_id
    }
  end
end
