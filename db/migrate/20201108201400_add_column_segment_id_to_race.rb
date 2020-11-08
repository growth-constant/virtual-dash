class AddColumnSegmentIdToRace < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :segment_id, :string
  end
end
