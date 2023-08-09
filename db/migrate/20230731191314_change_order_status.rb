class ChangeOrderStatus < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :status, :string, default: "new"
  end

  def down
    change_column :orders, :status, :string
  end
end
