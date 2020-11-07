class AddCredentialsOtherFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expires_at, :integer
    add_column :users, :refresh_token, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :image_medium, :string
  end
end
