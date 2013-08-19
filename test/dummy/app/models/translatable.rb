class Translatable < ActiveRecord::Base

  attr_translatable :name, :age

  slug :name

end
