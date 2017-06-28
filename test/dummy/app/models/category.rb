class Category < ApplicationRecord

  belongs_to :shop, optional: true

  has_slug :name, scope: :shop_id

end
