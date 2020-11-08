class CreateRaceCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :race_categories do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
