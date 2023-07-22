class Review < ApplicationRecord
  belongs_to :product
  has_many_attached :images
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "customer_name", "id", "product_id", "rating", "updated_at","images_attachments", "images_blobs", "product"]
  end
  # Other model code...
end