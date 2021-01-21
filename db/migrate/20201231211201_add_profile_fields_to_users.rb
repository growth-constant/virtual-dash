class AddProfileFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :profile_complete, :boolean, default: false
    add_column :users, :birthdate, :date
  end
end
