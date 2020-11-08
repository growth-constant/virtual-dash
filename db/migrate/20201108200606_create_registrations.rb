class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.references :race, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :race_category, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
