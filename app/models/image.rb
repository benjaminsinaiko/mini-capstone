class Image < ApplicationRecord
  belongs_to :product, optional: true

  def as_json
    {
      images: image_url,
      product_id: product_id
    }
  end
end
