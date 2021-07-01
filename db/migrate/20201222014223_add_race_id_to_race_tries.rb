class AddRaceIdToRaceTries < ActiveRecord::Migration[6.0]
  def change
    add_column :race_tries, :race_id, :integer
  end
end
