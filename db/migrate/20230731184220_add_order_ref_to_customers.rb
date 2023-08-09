class AddOrderRefToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :order, null: false, foreign_key: true
  end
end
