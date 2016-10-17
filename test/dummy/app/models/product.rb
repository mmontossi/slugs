class Product < ActiveRecord::Base

  belongs_to :shop
  belongs_to :category

  has_slug :name, scope: %i(shop_id category_id)

end
