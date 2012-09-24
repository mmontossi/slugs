class CreateI18nModel < ActiveRecord::Migration
  def change
    create_table :i18n_models do |t|
      t.timestamps
    end
  end
end
