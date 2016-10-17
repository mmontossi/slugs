class User < ActiveRecord::Base

  has_slug :first_name, :last_name

end
