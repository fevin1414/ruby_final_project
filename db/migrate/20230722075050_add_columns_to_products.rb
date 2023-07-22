class AddColumnsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :on_sale, :boolean
    add_column :products, :newly_added, :boolean
    add_column :products, :recently_updated, :boolean
  end
end
