class TranslatableTranslation < ActiveRecord::Base
  
  self.table_name = :translatables_i18n
  
  attr_accessible :locale, :translatable_id, :name, :age, :slug
  
  belongs_to :translatables
  
  validates :locale, :name, :age, :slug, :presence => true    
  validates :locale, :inclusion => { :in => I18n.available_locales.map{|l|l.to_s} }
  validates :translatable_id, :uniqueness => { :scope => :locale }  
  
end
