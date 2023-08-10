class AddDefaultNameToCustomers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:customers, :name)
      add_column :customers, :name, :string, default: "Default Customer Name"
    end
  end
end
