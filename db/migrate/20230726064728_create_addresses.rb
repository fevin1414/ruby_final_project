class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :province_id
      t.integer :user_id

      t.timestamps
    end
  end
end
