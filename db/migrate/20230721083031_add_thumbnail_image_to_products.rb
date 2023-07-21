class AddThumbnailImageToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :thumbnail_image, :string
  end
end
