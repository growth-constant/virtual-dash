class AddFieldsToRaceTries < ActiveRecord::Migration[6.0]
  def change
    add_column :race_tries, :moving_time, :integer
    add_column :race_tries, :start_date_local, :datetime
  end
end
