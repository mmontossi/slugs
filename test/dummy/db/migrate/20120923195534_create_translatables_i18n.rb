class CreateTranslatablesI18n < ActiveRecord::Migration
  def change 
    create_table :translatables_i18n do |t|    
      t.integer :translatable_id, :null => false
      t.string :locale, :null => false        
      t.string :name, :null => false
      t.integer :age, :null => false
      t.string :slug, :null => false
      t.timestamps 
    end
    add_index :translatables_i18n, :translatable_id
    add_index :translatables_i18n, :locale
    add_index :translatables_i18n, :name
    add_index :translatables_i18n, :created_at
    add_index :translatables_i18n, :updated_at    
  end  
end
