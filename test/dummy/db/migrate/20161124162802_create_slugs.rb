class CreateSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :slugs do |t|
      t.integer :sluggable_id
      t.string :sluggable_type
      t.string :value

      t.timestamps null: false
    end

    add_index :slugs, :sluggable_id
    add_index :slugs, :sluggable_type
    add_index :slugs, :value
  end
end
