class Translatable < ActiveRecord::Base

  attr_translatable :name, :age

  has_slug :name

end
