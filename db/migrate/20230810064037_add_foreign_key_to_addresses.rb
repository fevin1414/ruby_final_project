class AddForeignKeyToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :addresses, :provinces
  end
end
