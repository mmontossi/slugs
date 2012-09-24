class CreateSlugs < ActiveRecord::Migration
  def change
    create_table :slugs do |t|
      t.string :param, :null => false
      t.string :locale, :null => false 
      t.integer :sluggable_id, :null => false
      t.string :sluggable_type, :null => false
      t.timestamps          
    end    
    add_index :slugs, :param
    add_index :slugs, :locale 
    add_index :slugs, :sluggable_id
    add_index :slugs, :sluggable_type
    add_index :slugs, :created_at
    add_index :slugs, :updated_at
  end
end
