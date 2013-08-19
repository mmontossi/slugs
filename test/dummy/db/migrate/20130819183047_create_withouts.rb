class CreateWithouts < ActiveRecord::Migration
  def change
    create_table :withouts do |t|
      t.string :name

      t.timestamps
    end
  end
end
