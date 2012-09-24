class I18nModel < ActiveRecord::Base 
  
  attr_accessible :name, :age
  attr_translatable :name, :age
  
  slug :name
  
end