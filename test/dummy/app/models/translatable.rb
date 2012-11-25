class Translatable < ActiveRecord::Base 
  
  attr_accessible :name, :age, :slug
  attr_translatable :name, :age
  
  slug :name
  
end
