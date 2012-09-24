class Model < ActiveRecord::Base 
  
  attr_accessible :name, :age
  
  slug :name
  
end