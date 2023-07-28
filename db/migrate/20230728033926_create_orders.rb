class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :total
      t.integer :user_id
      t.integer :address_id

      t.timestamps
    end
  end
end
