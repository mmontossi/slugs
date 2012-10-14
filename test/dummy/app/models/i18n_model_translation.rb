class I18nModelTranslation < ActiveRecord::Base
  
  self.table_name = :i18n_models_i18n
  
  attr_accessible :locale, :i18n_model_id, :name, :age, :slug
  
  belongs_to :i18n_models
  
  validates :locale, :name, :age, :slug, :presence => true    
  validates :locale, :inclusion => { :in => I18n.available_locales.map{|l|l.to_s} }
  validates :i18n_model_id, :uniqueness => { :scope => :locale }  
  
end