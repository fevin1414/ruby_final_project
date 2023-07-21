class Product < ApplicationRecord
  # ...

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at", "stock", "description", "price", "image","image_id"]
  end

  belongs_to :category

  mount_uploader :image, ImageUploader
end
