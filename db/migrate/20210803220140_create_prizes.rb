class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :currency, null: false, :default => 'usd'
      t.string :stripe_transfer_id
      
      t.timestamps
    end
  end
end
