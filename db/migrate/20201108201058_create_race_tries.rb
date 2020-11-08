class CreateRaceTries < ActiveRecord::Migration[6.0]
  def change
    create_table :race_tries do |t|
      t.references :registration, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :segment_id
      t.integer :duration
      t.datetime :start

      t.timestamps
    end
    add_index :race_tries, :start
  end
end
