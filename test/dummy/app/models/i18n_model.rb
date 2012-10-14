class I18nModel < ActiveRecord::Base 
  
  attr_accessible :name, :age, :slug
  attr_translatable :name, :age, :slug
  
  slug :name
  
end