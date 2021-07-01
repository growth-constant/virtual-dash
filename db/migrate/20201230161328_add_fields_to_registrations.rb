class AddFieldsToRegistrations < ActiveRecord::Migration[6.0]
  def change
    change_column_default :registrations, :status, from: "", to: "require_agreements"
    change_column_null :registrations, :race_category_id, from: false, to: true
    remove_column :registrations, :race_category_id
    add_column :registrations, :payment_status, :string, default: "unpaid"
    add_column :registrations, :agreements_signed, :boolean, default: false
    add_column :registrations, :session_id, :string
  end
end
