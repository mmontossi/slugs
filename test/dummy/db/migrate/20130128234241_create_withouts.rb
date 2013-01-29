class CreateWithouts < ActiveRecord::Migration
  def change

    create_table :withouts do |t|
      t.string :name
    end
   
  end
end
