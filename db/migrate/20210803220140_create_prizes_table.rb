class CreatePrizesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes_tables do |t|
      t.references :user_id, null: false, foreign_key: true
      t.references :race_id, null: false, foreign_key: true
      t.integer :amount
      t.string :currency
      t.string :strpe_transfer_id
    end
  end
end
