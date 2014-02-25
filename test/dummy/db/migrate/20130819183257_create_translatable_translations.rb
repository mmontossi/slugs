class CreateTranslatableTranslations < ActiveRecord::Migration
  def change
    create_table :translatable_translations do |t|
      t.integer :translatable_id
      t.string :locale
      t.string :name
      t.integer :age
      t.string :slug

      t.timestamps 
    end
    add_index :translatable_translations, :translatable_id
    add_index :translatable_translations, :locale
  end
end
