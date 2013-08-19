class CreateTranslatableTranslations < ActiveRecord::Migration
  def change
    create_table :translatable_translations do |t|
      t.integer :translatable_id
      t.string :locale
      t.string :name
      t.string :slug
      t.integer :age

      t.timestamps 
    end
    add_index :translatable_translations, :translatable_id
    add_index :translatable_translations, :locale
  end
end
