class TranslatableTranslation < ActiveRecord::Base
 
  belongs_to :translatables
 
  validates :locale, presence: true
  validates :translatable_id, uniqueness: { scope: :locale }
 
end
