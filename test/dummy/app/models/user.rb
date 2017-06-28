class User < ApplicationRecord

  has_slug :first_name, :last_name

end
