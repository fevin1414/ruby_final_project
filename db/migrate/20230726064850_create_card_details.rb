class CreateCardDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :card_details do |t|
      t.string :card_number
      t.string :cardholder_name
      t.string :expiry_date
      t.string :cvv
      t.string :billing_street
      t.string :billing_city
      t.integer :billing_province_id
      t.integer :billing_user_id
      t.integer :user_id

      t.timestamps
    end
  end
end
