class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
      t.string :title
      t.text :description
      t.string :country
      t.string :state
      t.string :city
      t.datetime :enddate

      t.timestamps
    end
  end
end
