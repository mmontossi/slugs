class CreateTranslatables < ActiveRecord::Migration
  def change
    create_table :translatables do |t|
      t.timestamps
    end
  end
end
