class AddProductDataToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :product_data, :json,null: true
  end
end
