class AddOrderDetailsToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :subtotal, :decimal, null: true
    add_column :customers, :gst, :decimal, null: true
    add_column :customers, :pst, :decimal, null: true
    add_column :customers, :hst, :decimal, null: true
    add_column :customers, :total_with_taxes, :decimal, null: true
  end
end
