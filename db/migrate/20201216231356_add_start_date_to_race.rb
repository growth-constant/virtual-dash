class AddStartDateToRace < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :startdate, :datetime
  end
end
