class AddUserIdToRace < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :user_id, :integer
  end
end
