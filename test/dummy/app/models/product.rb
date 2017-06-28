class Product < ApplicationRecord

  belongs_to :shop, optional: true
  belongs_to :category, optional: true

  has_slug :name, scope: %i(shop_id category_id)

end
