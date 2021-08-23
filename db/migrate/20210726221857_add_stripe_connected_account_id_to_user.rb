class AddStripeConnectedAccountIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_conn_acc_id, :string
  end
end
