class AddIdFromStravaForRaceTryRegister < ActiveRecord::Migration[6.0]
  def change
    add_column :race_tries, :race_try_id, :bigint
  end
end
