class AddFieldsToRaces < ActiveRecord::Migration[6.0]
  def change
    add_column :races, :activity_type, :string
    add_column :races, :name, :string

    add_column :races, :distance, :float, precision: 2
    add_column :races, :average_grade, :float, precision: 1
    add_column :races, :maximum_grade, :float, precision: 2
    add_column :races, :elevation_high, :float, precision: 1
    add_column :races, :elevation_low, :float, precision: 1
    add_column :races, :start_latlng, :string, array: true
    add_column :races, :end_latlng, :string, array: true
    add_column :races, :all_data, :jsonb
  end
end
