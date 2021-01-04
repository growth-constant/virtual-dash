class AddPriceColumnToRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end
end
