class AddCustomerIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :customer, foreign_key: true, null: true
  end
end
