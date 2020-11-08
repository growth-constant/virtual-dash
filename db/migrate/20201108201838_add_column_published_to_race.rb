class AddColumnPublishedToRace < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :published, :boolean
  end
end
