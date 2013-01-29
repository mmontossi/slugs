class Translatable < ActiveRecord::Base 
  
  attr_accessible :dummy, :name, :age, :slug
  attr_translatable :name, :age
  
  slug :name
  
end
