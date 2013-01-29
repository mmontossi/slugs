class CreateTranslatables < ActiveRecord::Migration
  def change

    create_table :translatables do |t|
      t.string :dummy 
    end

  end
end
