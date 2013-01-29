class CreateTranslatablesI18n < ActiveRecord::Migration
  def change 

    create_table :translatables_i18n do |t|    
      t.integer :translatable_id, :null => false
      t.string :locale, :null => false        
      t.string :name, :null => false
      t.integer :age, :null => false
      t.string :slug, :null => false
    end

  end  
end
