class CreateTranslatables < ActiveRecord::Migration
  def change
    create_table :translatables do |t|
      t.string :name
      t.integer :age
      t.string :slug

      t.timestamps
    end
  end
end
