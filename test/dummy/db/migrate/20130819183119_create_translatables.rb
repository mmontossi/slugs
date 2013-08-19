class CreateTranslatables < ActiveRecord::Migration
  def change
    create_table :translatables do |t|
      t.string :dummy

      t.timestamps
    end
  end
end
