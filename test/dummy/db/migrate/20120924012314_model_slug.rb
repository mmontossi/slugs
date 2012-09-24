class ModelSlug < ActiveRecord::Migration
  def change
    add_column :models, :slug, :string
  end
end
