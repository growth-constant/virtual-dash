class AddRoleFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :integer, default: User.roles[:athlete]
  end
end
