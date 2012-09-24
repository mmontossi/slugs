class CreateI18nModelsI18n < ActiveRecord::Migration
  def change 
    create_table :i18n_models_i18n do |t|    
      t.integer :i18n_model_id, :null => false
      t.string :locale, :null => false        
      t.string :name, :null => false
      t.timestamps 
    end
    add_index :i18n_models_i18n, :i18n_model_id
    add_index :i18n_models_i18n, :locale
    add_index :i18n_models_i18n, :name
    add_index :i18n_models_i18n, :created_at
    add_index :i18n_models_i18n, :updated_at    
  end  
end
