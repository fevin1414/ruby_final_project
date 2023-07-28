class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.decimal :total_price, default: 0.0

      t.timestamps
    end
  end
end
