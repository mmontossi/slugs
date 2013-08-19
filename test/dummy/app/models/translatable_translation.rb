class TranslatableTranslation < ActiveRecord::Base
  
  belongs_to :translatables
  
  validates :locale, presence: true    
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :translatable_id, uniqueness: { scope: :locale }  
  
end
