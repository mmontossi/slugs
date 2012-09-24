class I18nModelAge < ActiveRecord::Migration
  def change
    add_column :i18n_models_i18n, :age, :integer 
  end
end
