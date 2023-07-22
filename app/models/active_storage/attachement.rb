class ActiveStorage::Attachment < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id", "name", "record_id", "record_type","content", "created_at", "customer_name", "id", "product_id", "rating", "updated_at", "images_attachments_id", "product","category_id", "created_at", "description", "id", "name", "price", "stock", "updated_at","on_sale","newly_added","recently_updated","created_at", "id", "product_id", "updated_at","category", "product_images", "reviews"]
  end
end