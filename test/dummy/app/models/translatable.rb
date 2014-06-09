class Translatable < ActiveRecord::Base
 
  attr_accessible :name, :age if Rails::VERSION::MAJOR < 4
  attr_translatable :name, :age

  has_slug :name

end
