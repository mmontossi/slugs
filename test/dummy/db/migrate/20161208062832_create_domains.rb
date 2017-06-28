class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|

      t.timestamps null: false
    end
  end
end
