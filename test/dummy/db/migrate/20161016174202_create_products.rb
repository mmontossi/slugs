class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :shop_id
      t.integer :category_id
      t.string :slug
    end
  end
end
