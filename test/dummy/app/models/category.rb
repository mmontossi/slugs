class Category < ActiveRecord::Base

  belongs_to :shop

  has_slug :name, scope: :shop_id

end
